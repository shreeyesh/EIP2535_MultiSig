// SPDX-License-Identifier: MIT
pragma solidity ^0.7.6;
import "./libraries/LibDiamond.sol";
contract MultiSigWallet is IMultiSig {
    
    address[] public owners;
    mapping(address => bool) public isOwner;
    uint public numConfirmationsRequired;

    constructor(address[] memory _owners, uint _numConfirmationsRequired) {
        require(_owners.length > 0, "owners required");
        require(
            _numConfirmationsRequired > 0 &&
                _numConfirmationsRequired <= _owners.length,
            "invalid number of required confirmations"
        );
        for (uint i = 0; i < _owners.length; i++) {
            address owner = _owners[i];

            require(owner != address(0), "invalid owner");
            require(!isOwner[owner], "owner not unique");

            isOwner[owner] = true;
            owners.push(owner);
        }

        numConfirmationsRequired = _numConfirmationsRequired;
    }
	receive() external payable {
    	LibDiamond.DiamondStorage storage ds = LibDiamond.diamondStorage(); 
		 payable(ds.contractOwner).transfer(msg.value());
	}
	
	fallback() external payable {
    	LibDiamond.DiamondStorage storage ds = LibDiamond.diamondStorage(); 
		payable(ds.contractOwner).transfer(msg.value());
	}
   
    // LibDiamond.DiamondStorage storage ds = LibDiamond.diamondStorage(); 
    // Transaction[] transactions;
    // DepositRecords storage deposit = ds.indDepositRecord[_account][_market][_commitment];

    function getTransaction(uint _txIndex)
        external
        view
        returns (
            address to,
            uint value,
            bytes memory data,
            bool executed,
            uint numConfirmations
        )
        {   LibDiamond.DiamondStorage storage ds = LibDiamond.diamondStorage(); 
            ds.Transaction storage transaction = transactions[_txIndex];
        return (
            transaction.to,
            transaction.value,
            transaction.data,
            transaction.executed,
            transaction.numConfirmations
            );
        
    	
        LibDiamond.getTransaction(_txIndex);
        }

    function submitTransaction(
        address _to,
        uint _value,
        bytes memory _data
    ) external  {
        LibDiamond.DiamondStorage storage ds = LibDiamond.diamondStorage(); 
        LibDiamond.submitTransaction(
        _to,
        _value,
        _data
        );
    }

     function executeTransaction(uint _txIndex) external{
        LibDiamond.DiamondStorage storage ds = LibDiamond.diamondStorage(); 
        LibDiamond.executeTransaction(_txIndex);
     }
    function confirmTransaction(uint _txIndex) external{
        LibDiamond.DiamondStorage storage ds = LibDiamond.diamondStorage(); 
        LibDiamond.confirmTransaction(_txIndex);
    }

    function revokeConfirmation(uint _txIndex) external{
        LibDiamond.DiamondStorage storage ds = LibDiamond.diamondStorage(); 
        LibDiamond.revokeConfirmation(_txIndex);

    }
     
    function getOwners() external view returns (address[] memory) {
        LibDiamond.DiamondStorage storage ds = LibDiamond.diamondStorage(); 
        LibDiamond.getOwners();
    } 

    function getTransactionCount() external view returns (uint){
        LibDiamond.DiamondStorage storage ds = LibDiamond.diamondStorage(); 
        LibDiamond.getTransactionCount();

    }

    modifier onlyOwner() {
        require(isOwner[msg.sender], "not owner");
        _;
    }

    modifier txExists(uint _txIndex) {
        require(_txIndex < transactions.length, "tx does not exist");
        _;
    }

    modifier notExecuted(uint _txIndex) {
        require(!transactions[_txIndex].executed, "tx already executed");
        _;
    }

    modifier notConfirmed(uint _txIndex) {
        require(!isConfirmed[_txIndex][msg.sender], "tx already confirmed");
        _;
    }

    receive() external payable {
        emit Deposit(msg.sender, msg.value, address(this).balance);
    }

    }

