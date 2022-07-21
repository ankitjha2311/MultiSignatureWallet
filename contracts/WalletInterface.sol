// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

interface WalletInterface {
    /**
     * @dev Allows admin to add new owner to the wallet
     * @param owner Address of the new owner
     */
    function addOwner(address owner) external;

    /**
     * @dev Allows admin to remove owner from the wallet
     * @param owner Address of the new owner
     */
    function removeOwner(address owner) external;

    /**
     * @dev Allows admin to transfer owner from one wallet to  another
     * @param _from Address of the old owner
     * @param _to Address of the new owner
     */
    function transferOwner(address _from, address _to) external;

    /**
     * @dev Allows an owner to confirm a transaction.
     * @param transactionId Transaction ID.
     */
    function confirmTransaction(uint256 transactionId) external;

    /**
     * @dev Allows anyone to execute a confirmed transaction.
     * @param transactionId Transaction ID.
     */
    function executeTransaction(uint256 transactionId) external;

    /**
     * @dev Allows an owner to revoke a confirmation for a transaction.
     * @param transactionId Transaction ID.
     */
    function revokeTransaction(uint256 transactionId) external;
}
