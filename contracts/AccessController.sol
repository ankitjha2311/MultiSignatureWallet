// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

import "../node_modules/@openzeppelin/contracts/utils/math/SafeMath.sol";
import "./WalletInterface.sol";

contract AccessController {
    using SafeMath for uint256;
    address public admin;
    address[] public owners;
    mapping(address => bool) public isOwner;
    uint256 consensus;


   // Modifiers


   
    modifier notOwnerExistsMod(address owner) {
        require(isOwner[owner] == false, "owner address does not exist");
        _;
    }
    modifier ownerAlreadyExit(address owner) {
        require(isOwner[owner] == true, "Wallet address already exist");
        _;
    }
    modifier notNull(address _address) {
        require(_address != address(0), "Invalid Address");
        _;
    }
   
     modifier onlyAdmin() {
        require(msg.sender == admin, "Only Admin has the right to access this function");
        _;
    }

   // Contract Events
    event Deposit(address indexed sender, uint256 value);
    event Submit(uint256 indexed txId);
    event Confirm(address indexed sender, uint256 indexed txId);
    event Execute(uint256 indexed txId);
    event FailedExecution(uint256 indexed txId);
    event RevokeTx(address indexed sender, uint256 indexed txId);
    event AddOwner(address indexed owner);
    event RemoveOwner(address indexed owner);
    event UpdateConsent(uint256 consensus);
    event AdminTransfer(address indexed newAdmin);

  


// constructor for access control



    constructor(address[] memory _owners) {
        admin = msg.sender;
        require(
            _owners.length >= 3,
            "For initialization need atlest 3 signators"
        );
        for (uint256 i = 0; i < _owners.length; i++) {
            isOwner[_owners[i]] = true;
        }
        owners = _owners;
        uint256 num = SafeMath.mul(owners.length, 60);
        consensus = SafeMath.div(num, 100);
    }

    
// Add new owner only Admin can invoke it

    function addOwner(address owner)
        public
        onlyAdmin
        notNull(owner)
        notOwnerExistsMod(owner)
    {
        isOwner[owner] = true;
        owners.push(owner);
        emit AddOwner(owner);(owner);
        updateConsensus(owners);
    }

// Remove  owner only Admin can invoke it
    function removeOwner(address owner)
        public
        onlyAdmin
        notNull(owner)
        ownerAlreadyExit(owner)
    {
        
        isOwner[owner] = false;
         for (uint256 i = 0; i < owners.length - 1; i++)
            if (owners[i] == owner) {
                owners[i] = owners[owners.length - 1];
                break;
            }
        owners.pop();
        updateConsensus(owners);
    }

// Ownership tranfer by admin account

    function transferOwner(address _from, address _to)
        public
        onlyAdmin
        notNull(_from)
        notNull(_to)
        ownerAlreadyExit(_from)
        notOwnerExistsMod(_to)
    {
       
        for (uint256 i = 0; i < owners.length; i++)
            if (owners[i] == _from) {
                owners[i] = _to;
                break;
            }
        isOwner[_from] = false;
        isOwner[_to] = true;
        emit RemoveOwner(_from);
        emit AddOwner(_to);
    }

    function renounceAdmin(address newAdmin) public onlyAdmin {
        admin = newAdmin;
        emit AdminTransfer(newAdmin);
    }


    function updateConsensus(address[] memory _owners) internal {
        uint256 num = SafeMath.mul(_owners.length, 60);
        consensus = SafeMath.div(num, 100);
        emit UpdateConsent(consensus);
    }
}


contract AccessControlWallet is AccessController {
    using SafeMath for uint256;

    WalletInterface _walletInterface;

    constructor(WalletInterface wallet_, address[] memory _owners) AccessController (_owners){
        _walletInterface = WalletInterface(wallet_);
        admin = msg.sender;
    }

    function getOwners() external view returns (address[] memory) {
        return owners;
    }

    function getAdmin() external view returns (address) {
        return admin;
    }
}
