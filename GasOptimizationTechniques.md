
*RUNTIME COST OPTIMIZATION*

- Make function arguments calldata instead of memory (calldata is cheaper to read from)
- Unchecking i in a for loop 
- (or uncheck any arithmetic that is sure not to overflow)
- Loading state variables into memory
- Caching array elements
- Packing variables that are accessed together in storage slots
- (Generally won't save gas to pack variables that aren't used together as it cost gas to unpack them)
- Label variables that won't change "constant" or "immutable".  Variables will be stored in bytecode instead of storage
- Use bitwise operators for some multiplication or division (multiplying by 2 in bitwise looks like this: variable << 1.  The bit is being shifted to the left once which is the same as doubling it)
- Use Assembly whenever we can. 
- Other minor things that might help:
    - ">=" is slightly cheaper than ">".
    - Using 2 require statements is cheaper than using only 1 with &&.
    - Writing on a used storage slot is cheaper than writing on a new one.
    - The order and names of external functions do influence their gas cost! In general, functions declared earlier are cheaper to call.
    - ++i is slightly cheaper than i++ and i = i + 1 because it directly writes onto the i variable (rather than making a copy).


*DEPLOYMENT COST OPTIMIZATION*

- Use internal or private functions to eliminate duplicate code. For example:
        ```
        contract myContract {

            function foo() external {
                _commonFunction();
                // Do something...
            }
            
            function bar() external {
                _commonFunction();
                // Do something else...
            }
            
            function _commonFunction() internal {
                // Do something common...
            }
        ```

- Modifier wrappers embed code into each function.  That can be costly if the same Modifier is used repeatedly. 
  Instead, use an internal or private function and put it in the modifer.  For example:
  ```
    modifier myExpensiveModifier() {
        _myExpensiveModifier();
        _;
    }

    function _myExpensiveModifier() internal view {
        // do something gas expensive
    }

    function aFunction() public view myExpensiveModifier() {
        // ...
    }
  ```

- Use custom errors. Using an error as a function instead of a string uses less bytes 
  since the function selector is only 4 bytes long. For example:
  ```
    contract A {

        // Define a custom error
        error unauthorizedError();
        
        function isAuthorized() public {
            if (msg.sender != owner) {
                revert unauthorizedError();
            }
        }
    }
  ```

- Use constructors for pre-computation as much as possible as constructors are not included in the deployed bytecode.

*TECHNIQUES FROM LECTURE 8*

- Break out of loops as fast as possible
- Don't copy arrays from storage to memory, use a storage pointer
- Avoid repetitive checks
- Refunds: free storage slots by zeroing variables as soon as you don't need them anymore.
- Data Types and Packing:
    - Use "bytes32" whenever possible
    - Type "bytes" should be used over "byte[]"
    - Limit length of bytes when possible: use "bytes1" instead of "bytes32"
- Strings: using "bytes32" is cheaper than using "string" type
- Mapping vs Array: maps are cheaper than arrays but array can be better for smaller data types
- Packing variables: pack blocks into one Storage slot if smaller than a word of 32 bytes
- Variables:
    - use events rather than storing data
    - Avoid public variables
    - Could avoid using storage by employing memory arrays
    - Name the return value in the function header to avoid creating a local variable
- Functions: Mark external when you can and not public.
- Function Order:
    - Reduce public variables
    - Put frequently called functions first
    - Optimize function name with this website: https://emn178.github.io/solidity-optimize-name/
- Compressed input data: Pack in the input parameters into a function by ordering them by size.
- Modifiers: Code of modifiers is inserted into the function. Making a modifier a function call instead can help.
- Loops:
    - Don't use storage variables inside loops
    - Optimize loops by minimizing number of instructions
    - Take unnecessary values out of loops
    - Break out as fast as possilbe
- Custom errors: use error statement like "error Unauthorized();"
- Use the Optimizer:
    - make sure optimizer is turned on when compiling
    - Use optimizer and set counter to high values or leave at 200
    - Use libraries
    - Require and Assert:
        - Use Require at runtime
        - Use Assert for conditions that should NEVER fail
        - Reduce error message text
