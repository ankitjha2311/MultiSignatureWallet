# MultiSignatureWallet

### Scalable multi-signature wallet contract, which requires a minimum of 60% authorization by the signatory wallets to perform a transaction.
## with
### An access control contract that stores the signatories of this multi-sig wallet by address. This access registry contract will have its own admin. Further, the access registry contract must be capable of adding, revoking, renouncing, and transfer of signatory functionalities.


## Smart contract address on Ropsten Testnet : 0x9cf22eF6F6dc6F1CAC686A2e5f21F15106cF47A2



  
    PS C:\Users\ankit\Desktop\Blockchain\MultiSignatureWallet> truffle migrate --network ropsten

    Compiling your contracts...
    ===========================
    > Compiling .\contracts\AccessControlWallet.sol
    > Compiling .\contracts\AccessController.sol
    > Compiling .\contracts\Migrations.sol
    > Compiling .\contracts\MultiSigWallet.sol
    > Compiling .\contracts\WalletInterface.sol
    > Compiling .\node_modules\@openzeppelin\contracts\utils\math\SafeMath.sol
    > Artifacts written to C:\Users\ankit\Desktop\Blockchain\MultiSignatureWallet\build\contracts
    > Compiled successfully using:
       - solc: 0.8.15+commit.e14f2714.Emscripten.clang


    Starting migrations...
    ======================
    > Network name:    'ropsten'
    > Network id:      3
    > Block gas limit: 29971729 (0x1c95511)


    1_initial_migration.js
    ======================

     Deploying 'Migrations'
     ----------------------
     > transaction hash:    0xd2ee66f3fcd0fb594d8ad22f130f98482ae2e8fb3ff91455328c80a75ab04e9f
     > Blocks: 1            Seconds: 26
     > contract address:    0x9cf22eF6F6dc6F1CAC686A2e5f21F15106cF47A2
     > block number:        12638544
     > confirmation number: 2 (block: 12638546)
     > Saving migration to chain.
     > Saving artifacts
     -------------------------------------
     > Total cost:     0.000625385001751078 ETH


    2_deploy_wallet.js
    ==================

     Deploying 'MultiSigWallet'
     --------------------------
     > transaction hash:    0x0c190b6a1da8728cb9e187d72e74b65f421ef45abcdc4d67266f70708cacef42
     > Blocks: 2            Seconds: 18
     > contract address:    0x4fAD07D036D7de02dc679d78E109BD5ae8d012B4
     > block number:        12638549
     > block timestamp:     1658429808
     > account:             0xFAbC26A15ec223135c5b6b1237ACfE54E43Fc7d3
     > balance:             0.991097347475072573
     > gas used:            3264994 (0x31d1e2)
     > gas price:           2.500000007 gwei
     > value sent:          0 ETH
     > total cost:          0.008162485022854958 ETH

     Pausing for 2 confirmations...

     -------------------------------
     > confirmation number: 1 (block: 12638550)
     > confirmation number: 2 (block: 12638551)

     Deploying 'AccessControlWallet'
     -------------------------------
     > transaction hash:    0x6d5d7d03698027d059a7252b7be3d6dde67708818e081568a5d38edca706c4d8
     > Blocks: 1            Seconds: 17
     > contract address:    0x77b45d99c095324b0F1707CD2097Cdecb369bd65
     > block number:        12638552
     > block timestamp:     1658429868
     > account:             0xFAbC26A15ec223135c5b6b1237ACfE54E43Fc7d3
     > balance:             0.986921909963381348
     > gas used:            1670175 (0x197c1f)
     > gas price:           2.500000007 gwei
     > value sent:          0 ETH
     > total cost:          0.004175437511691225 ETH

     Pausing for 2 confirmations...

     -------------------------------
     > confirmation number: 1 (block: 12638553)
     > confirmation number: 2 (block: 12638554)
     > Saving migration to chain.
     > Saving artifacts
     -------------------------------------
     > Total cost:     0.012337922534546183 ETH

    Summary
    =======
    > Total deployments:   3
    > Final cost:          0.012963307536297261 ETH
