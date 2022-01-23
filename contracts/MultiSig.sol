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
		 payable(ds.contractOwner).transfer(_msgValue());
	}
	
	fallback() external payable {
    	LibDiamond.DiamondStorage storage ds = LibDiamond.diamondStorage(); 
		payable(ds.contractOwner).transfer(_msgValue());
	}
   
    // LibDiamond.DiamondStorage storage ds = LibDiamond.diamondStorage(); 
    Transaction[] transactions;
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
        {
    	LibDiamond.DiamondStorage storage ds = LibDiamond.diamondStorage(); 
        LibDiamond.getTransaction(uint _txIndex);
        }

    function submitTransaction(
        address _to,
        uint _value,
        bytes memory _data
    ) external  {
        LibDiamond.DiamondStorage storage ds = LibDiamond.diamondStorage(); 
        LibDiamond.submitTransaction(
        address _to,
        uint _value,
        bytes memory _data
        );
    }

     function executeTransaction(uint _txIndex) external{
        LibDiamond.DiamondStorage storage ds = LibDiamond.diamondStorage(); 
        LibDiamond.executeTransaction(uint _txIndex);
     }
    function confirmTransaction(uint _txIndex) external{
        LibDiamond.DiamondStorage storage ds = LibDiamond.diamondStorage(); 
        LibDiamond.confirmTransaction(uint _txIndex);

    }

    function revokeConfirmation(uint _txIndex) external{
        LibDiamond.DiamondStorage storage ds = LibDiamond.diamondStorage(); 
        LibDiamond.revokeConfirmation(uint _txIndex);

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

