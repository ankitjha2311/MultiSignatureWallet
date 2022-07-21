// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

import "../node_modules/@openzeppelin/contracts/utils/math/SafeMath.sol";
import "./WalletInterface.sol";
import "./AccessController.sol";

contract MultiSigWallet is AccessController {
    using SafeMath for uint256;

// State Variables 

    struct Transaction {
        bool executed;
        address receiver;
        uint256 value;
        bytes data;
    }



    uint256 public transactionCount;
    mapping(uint256 => Transaction) public transactions;
    Transaction[] public _validTransactions;


    mapping(uint256 => mapping(address => bool)) public confirmations;


    fallback() external payable {
        if (msg.value > 0) {
            emit Deposit(msg.sender, msg.value);
        }
    }

    receive() external payable {
        if (msg.value > 0) {
            emit Deposit(msg.sender, msg.value);
        }
    }

 
    modifier isOwnerMod(address owner) {
        require(
            isOwner[owner] == true,
            "Access Denied: Your are unauthoorized for this action"
        );
        _;
    }

    modifier isConfirmedMod(uint256 txId, address owner) {
        require(
            confirmations[txId][owner] == false,
            "Transaction confirmation already sent"
        );
        _;
    }

    modifier isExecutedMod(uint256 txId) {
        require(
            transactions[txId].executed == false,
            "Transaction already executed"
        );
        _;
    }

   
    constructor(address[] memory _owners) AccessController(_owners) {

    }

    function submitTransaction(
        address destination,
        uint256 value,
        bytes memory data
    ) public isOwnerMod(msg.sender)
         returns (uint256 txId) {

      txId = transactionCount;
      transactions[txId] = Transaction({
            receiver: destination,
            value: value,
            data: data,
            executed: false
        });

        transactionCount += 1;
        emit Submit(txId);
        confirmTransaction(txId);
    }

    function confirmTransaction(uint256 transactionId)
        public
        isOwnerMod(msg.sender)
        isConfirmedMod(transactionId, msg.sender)
        notNull(transactions[transactionId].receiver)
    {
        confirmations[transactionId][msg.sender] = true;
        emit Confirm(msg.sender, transactionId);
        executeTransaction(transactionId);
    }

  
    function executeTransaction(uint256 transactionId)
        public
        isOwnerMod(msg.sender)
        isExecutedMod(transactionId)
    {
        uint256 count = 0;
        bool consentReached;

      
        for (uint256 i = 0; i < owners.length; i++) {
       
            if (confirmations[transactionId][owners[i]]) count += 1;
        
            if (count >= consensus) consentReached = true;
        }

        if (consentReached) {
            Transaction storage txn = transactions[transactionId];
            txn.executed = true;
            (bool success, ) = txn.receiver.call{value: txn.value}(txn.data);
            if (success) {
                _validTransactions.push(txn);
                emit Execute(transactionId);
            } else {
                emit FailedExecution(transactionId);
                txn.executed = false;
            }
        }
    }

    function revokeTransaction(uint256 transactionId)
        external
        isOwnerMod(msg.sender)
        isConfirmedMod(transactionId, msg.sender)
        isExecutedMod(transactionId)
        notNull(transactions[transactionId].receiver)
    {
        confirmations[transactionId][msg.sender] = false;
        emit RevokeTx(msg.sender, transactionId);
    }


    function getOwners() external view returns (address[] memory) {
        return owners;
    }

    function getValidTransactions()
        external
        view
        returns (Transaction[] memory)
    {
        return _validTransactions;
    }

    function getQuorum() external view returns (uint256) {
        return consensus;
    }
}
