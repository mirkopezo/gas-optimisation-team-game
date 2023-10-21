// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.21;

contract GasContract {
    struct ImportantStruct {
        uint256 amount;
        uint256 valueA; // max 3 digits
        uint256 bigValue;
        uint256 valueB; // max 3 digits
        bool paymentStatus;
        address sender;
    }

    address private constant contractOwner = address(0x1234);
    mapping(address => uint256) public balances;
    mapping(address => ImportantStruct) private whiteListStruct;

    event AddedToWhitelist(address userAddress, uint256 tier);
    event WhiteListTransfer(address indexed);

    modifier onlyAdminOrOwner() {
        if (msg.sender == contractOwner) {
            _;
        } else {
            revert();
        }
    }

    constructor(address[] memory, uint256 _totalSupply) payable {
        balances[contractOwner] = _totalSupply;
    }

    function transfer(address _recipient, uint256 _amount, string calldata) public {
        balances[_recipient] += _amount;
    }

    function addToWhitelist(address _userAddrs, uint256 _tier) public onlyAdminOrOwner {
        if (_tier >= 255) revert();
        emit AddedToWhitelist(_userAddrs, _tier);
    }

    function whiteTransfer(address _recipient, uint256 _amount) public {
        address senderOfTx = msg.sender;
        whiteListStruct[senderOfTx] = ImportantStruct(_amount, 0, 0, 0, true, msg.sender);

        balances[senderOfTx] -= _amount;
        balances[_recipient] += _amount;

        emit WhiteListTransfer(_recipient);
    }

    function balanceOf(address _user) public view returns (uint256) {
        return balances[_user];
    }

    function getPaymentStatus(address sender) public view returns (bool, uint256) {
        return (whiteListStruct[sender].paymentStatus, whiteListStruct[sender].amount);
    }

    function administrators(uint256 _index) external pure returns (address) {
        if (_index == 0) return 0x3243Ed9fdCDE2345890DDEAf6b083CA4cF0F68f2;
        else if (_index == 1) return 0x2b263f55Bf2125159Ce8Ec2Bb575C649f822ab46;
        else if (_index == 2) return 0x0eD94Bc8435F3189966a49Ca1358a55d871FC3Bf;
        else if (_index == 3) return 0xeadb3d065f8d15cc05e92594523516aD36d1c834;
        else return address(0x1234);
    }

    function whitelist(address) external pure returns (uint256) {
        return 0;
    }
}
