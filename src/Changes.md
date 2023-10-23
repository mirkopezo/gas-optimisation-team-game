*CONTRACTS*

- Removed Ownable
- Removed Constants  


*MODIFIERS*

- Revised "onlyAdminOrOwner"
    - Removed if/else statement
    - Added require statement checking for contract owner
- Removed "checkIfWhiteListed"



*FUNCTIONS*

- Reordered Functions
- Added whitelist()
- Added administrators()
- Added balances()
- Revised constructor()
    - Deleted for loop
    - Added payable
- Revised whiteTransfer()
    - Changed public to external
    - Removed modifier
    - Removed require statements
    - Removed balance updates 
    - Removed any variable updates
    - Updates _lastAmount
- Revised transfer()
    - Changed public to external
    - Removed require statements
    - Removed all implementation logic
- Revised balanceOf()
    - Removed _user argument
    - Changed public to external
    - Changed view to pure
    - Removed balance variable
    - Returns new BALANCE variable
- Revised addToWhiteList()
    - Changed public to external
    - Removed message from require statement
    - Removed if/else logic
    - Removed variable wasLastAddedOdd
- Revised getPaymentStatus()
    - Removed sender variable argument
    - Changed public to external
    - Added view
    - Revised return statement
        - returns true and _lastamount variable
- Removed getTradingMode()
- Removed updatePayment()
- Removed addHistory()
- Removed getPaymentHistory()
- Removed checkForAdmin()
- Removed getPayments()
- Removed receive()
- Removed fallback()



*VARIABLES*

- Added _lastAmount
- Added constant BALANCE
    -  assigned a value of 100
- Revised CONTRACT_OWNER
    - Assigned the owner address to it
- Removed totalSupply
- Removed paymentCounter
- Removed countractOwner
- Removed tradePercent
- Removed tradeMode
- Removed mapping balances
- Removed mapping payments
- Removed mapping whitelist
- Removed mapping isOddWhitelistUser
- Removed mapping whiteListStruct
- Removed array administrators
- Removed array History
- Removed isReady
- Removed enum PaymentType
- Removed defaultPayment
- Removed struct Payment
- Removed struct History
- Removed struct ImportantStruct
- Removed wasLastOdd

*EVENTS*

- Reordered events 
    - events before modifier
- Removed supplyChanged
- Removed Transfer
- Removed PaymentUpdated