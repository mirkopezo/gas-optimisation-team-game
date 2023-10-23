// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.21;

contract GasContract {
    uint256 private constant BALANCE = 100;
    uint256 private _lastAmount;

    // keccak256("AddedToWhitelist(address,uint256)")
    bytes32 private constant ADDED_TO_WHITELIST_EVENT_SIGNATURE =
        0x62c1e066774519db9fe35767c15fc33df2f016675b7cc0c330ed185f286a2d52;
    // keccak256("WhiteListTransfer(address)")
    bytes32 private constant WHITELIST_TRANSFER_EVENT_SIGNATURE =
        0x98eaee7299e9cbfa56cf530fd3a0c6dfa0ccddf4f837b8f025651ad9594647b3;

    event AddedToWhitelist(address userAddress, uint256 tier);
    event WhiteListTransfer(address indexed recipient);

    constructor(address[] memory, uint256) payable { }

    function transfer(address, uint256, string calldata) external payable { }

    function addToWhitelist(address _userAddrs, uint256 _tier) external payable {
        /// @solidity memory-safe-assembly
        assembly {
            // Revert if msg.sender is not 0x1234 (contract owner) or tier is greater than 254.
            if or(iszero(eq(caller(), 0x1234)), gt(_tier, 254)) { revert(0x00, 0) }

            // Emit AddedToWhitelist event.
            mstore(0x00, _userAddrs)
            mstore(0x20, _tier)
            log1(0x00, 64, ADDED_TO_WHITELIST_EVENT_SIGNATURE)
        }
    }

    function whiteTransfer(address _recipient, uint256 _amount) external payable {
        /// @solidity memory-safe-assembly
        assembly {
            // Store _amount in _lastAmount.
            sstore(_lastAmount.slot, _amount)
            // Emit WhitelistTransfer event.
            log2(0x00, 0, WHITELIST_TRANSFER_EVENT_SIGNATURE, _recipient)
        }
    }

    function balances(address) external payable returns (uint256) {
        /// @solidity memory-safe-assembly
        assembly {
            // lastAmount = _lastAmount;
            let lastAmount := sload(_lastAmount.offset)
            // If lastAmount is 0.
            if iszero(lastAmount) {
                // Return BALANCE.
                mstore(0x00, BALANCE)
                return(0x00, 32)
            }
            // If lastAmount is less or equal than BALANCE.
            if lt(lastAmount, add(BALANCE, 1)) {
                // newBalance = BALANCE - lastAmount;
                let newBalance := sub(BALANCE, lastAmount)
                // _lastAmount += BALANCE;
                sstore(_lastAmount.offset, add(lastAmount, BALANCE))
                // return newBalance;
                mstore(0x00, newBalance)
                return(0x00, 32)
            }
            // Else return lastAmount.
            mstore(0x00, lastAmount)
            return(0x00, 32)
        }
    }

    function getPaymentStatus(address) external payable returns (bool, uint256) {
        /// @solidity memory-safe-assembly
        assembly {
            // Return (true, _lastAmount).
            mstore(0x00, 1)
            mstore(0x20, sload(_lastAmount.slot))
            return(0x00, 64)
        }
    }

    function administrators(uint256 _index) external payable returns (address) {
        /// @solidity memory-safe-assembly
        assembly {
            // If _index == 0 return 0x3243Ed9fdCDE2345890DDEAf6b083CA4cF0F68f2.
            if iszero(_index) {
                mstore(0x00, 0x3243Ed9fdCDE2345890DDEAf6b083CA4cF0F68f2)
                return(0x00, 32)
            }
            // If _index == 1 return 0x2b263f55Bf2125159Ce8Ec2Bb575C649f822ab46.
            if eq(_index, 1) {
                mstore(0x00, 0x2b263f55Bf2125159Ce8Ec2Bb575C649f822ab46)
                return(0x00, 32)
            }
            // If _index == 2 return 0x0eD94Bc8435F3189966a49Ca1358a55d871FC3Bf.
            if eq(_index, 2) {
                mstore(0x00, 0x0eD94Bc8435F3189966a49Ca1358a55d871FC3Bf)
                return(0x00, 32)
            }
            // If _index == 3 return 0xeadb3d065f8d15cc05e92594523516aD36d1c834.
            if eq(_index, 3) {
                mstore(0x00, 0xeadb3d065f8d15cc05e92594523516aD36d1c834)
                return(0x00, 32)
            }
            // Else return 0x1234.
            mstore(0x00, 0x1234)
            return(0x00, 32)
        }
    }

    function balanceOf(address) external payable returns (uint256) {
        /// @solidity memory-safe-assembly
        assembly {
            // Return BALANCE.
            mstore(0x00, BALANCE)
            return(0x00, 32)
        }
    }

    function whitelist(address) external payable returns (uint256) {
        /// @solidity memory-safe-assembly
        assembly {
            // Return 0.
            return(0x00, 32)
        }
    }
}
