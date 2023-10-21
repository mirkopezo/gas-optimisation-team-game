Before merging make sure that the deployment cost is lower than the current deployment cost. If that is case, change the deployment cost to the new value.

Current deployment cost: 179105

# GAS OPTIMSATION 

- Your task is to edit and optimise the Gas.sol contract. 
- You cannot edit the tests & 
- All the tests must pass.
- You can change the functionality of the contract as long as the tests pass. 
- Try to get the gas usage as low as possible. 



## To run tests & gas report with verbatim trace 
Run: `forge test --gas-report -vvvv`

## To run tests & gas report
Run: `forge test --gas-report`

## To run a specific test
RUN:`forge test --match-test {TESTNAME} -vvvv`
EG: `forge test --match-test test_onlyOwner -vvvv`

## Generate coverage report
`forge coverage --report lcov`

`genhtml lcov.info -o report --branch-coverage`

## Format code
`forge fmt`
