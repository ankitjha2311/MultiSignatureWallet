// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

interface WalletInterface {
 
 // Adds new owner in the multi singnature wallet. Accessed by admin only
    function addOwner(address owner) external;

 // Removes owner in the multi singnature wallet. Accessed by admin only
    function removeOwner(address owner) external;

// Ownership transfer function. Accessed by admin only
    function transferOwner(address _from, address _to) external;

// To confirm transaction by admin if multi singnature condition has been met
    function confirmTransaction(uint256 transactionId) external;

// Function to execute transaction, access by all 
    function executeTransaction(uint256 transactionId) external;

// Function to revoke the transaction, access by all 
    function revokeTransaction(uint256 transactionId) external;
}
