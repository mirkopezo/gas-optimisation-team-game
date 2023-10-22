// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.21;

contract GasContract {
    address private constant CONTRACT_OWNER = address(0x1234);
    uint256 private constant BALANCE = 100;
    uint256 private _lastAmount;

    event AddedToWhitelist(address userAddress, uint256 tier);
    event WhiteListTransfer(address indexed);

    constructor(address[] memory, uint256) payable {}

    function transfer(address, uint256, string calldata) external payable { }

    function addToWhitelist(address _userAddrs, uint256 _tier) external payable{
        require(msg.sender == CONTRACT_OWNER);
        if (_tier > 254) revert();
        emit AddedToWhitelist(_userAddrs, _tier);
    }

    function whiteTransfer(address _recipient, uint256 _amount) external payable{
        assembly {
            sstore(0, _amount)
        }
        emit WhiteListTransfer(_recipient);
    }

    function balances(address) external payable returns (uint256) {
        unchecked {
            if (_lastAmount == 0) {return BALANCE;
            } else if (_lastAmount <= BALANCE) {
                     uint256 newBalance = BALANCE - _lastAmount;
                    _lastAmount += BALANCE;
                    return newBalance;
            } else {
                return _lastAmount;
            }
        }
    }

    function getPaymentStatus(address) external payable returns (bool, uint256) {
        return (true, _lastAmount);
    }

    function administrators(uint256 _index) external payable returns (address) {
        if (_index == 0) return 0x3243Ed9fdCDE2345890DDEAf6b083CA4cF0F68f2;
        else if (_index == 1) return 0x2b263f55Bf2125159Ce8Ec2Bb575C649f822ab46;
        else if (_index == 2) return 0x0eD94Bc8435F3189966a49Ca1358a55d871FC3Bf;
        else if (_index == 3) return 0xeadb3d065f8d15cc05e92594523516aD36d1c834;
        else return CONTRACT_OWNER;
    }

    function balanceOf(address) external payable returns (uint256) {
        return BALANCE;
    }

    function whitelist(address) external payable returns (uint256 result) {
        assembly {
            result := 0
        }
    }   
}
