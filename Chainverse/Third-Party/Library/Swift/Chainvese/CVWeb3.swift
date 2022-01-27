//
//  CVWeb3.swift
//  Chainverse-SDK
//
//  Created by pham nam on 08/12/2021.
//


import Foundation
import web3swift
@objc public class CVWeb3: NSObject{
    struct Wallet {
        let address: String
        let data: Data
        let name: String
        let isHD: Bool
    }

    struct HDKey {
        let name: String?
        let address: String
    }
    
    @objc public var web3Client: Any?
    @objc public func initWeb3(endpoint: String){
        web3Client = web3(provider: Web3HttpProvider(URL(string: endpoint)!)!)
    }
    
    @objc public func getBalance(address: String) -> String {
        /*let walletAddress = EthereumAddress(address)! // Address which balance we want to know
        let balanceResult = try! web3.Eth.getBalance(address: walletAddress)
        let balanceString = Web3.Utils.formatToEthereumUnits(balanceResult, toUnits: .eth, decimals: 3)!
        
        return balanceString;*/
        
        return ""
    }
    
    @objc public func callFunction(_mnemonics: String,contractAddress: String, contractABI: String) ->  [String: Any] {
        let _password = ""
        let keystore = try! BIP32Keystore(
            mnemonics: _mnemonics,
            password: _password,
            mnemonicsPassword: "",
            language: .english)!
        let name = "New HD Wallet"
        let keyData = try! JSONEncoder().encode(keystore.keystoreParams)
        let address = keystore.addresses!.first!.address
        let wallet = Wallet(address: address, data: keyData, name: name, isHD: true)
        
        let data = wallet.data
        let keystoreManager: KeystoreManager
        if wallet.isHD {
            let keystore = BIP32Keystore(data)!
            keystoreManager = KeystoreManager([keystore])
        } else {
            let keystore = EthereumKeystoreV3(data)!
            keystoreManager = KeystoreManager([keystore])
        }
        
        let web3 = web3(provider: Web3HttpProvider(URL(string: "https://data-seed-prebsc-1-s1.binance.org:8545")!)!)
        web3.addKeystoreManager(keystoreManager)
        
        //let walletAddress = EthereumAddress(address)! // Your wallet address
        let contractMethod = "isGamePaused" // Contract method you want to call
        let contractAddress = EthereumAddress(contractAddress)!
        let abiVersion = 2 // Contract ABI version
        var params = [Any]()
        params.append(EthereumAddress("0x13f1A9097A7Cd7BeBC5Ad5c79160db3067FEf20E")!)
               
        let parameters = [params as AnyObject]
        //let extraData: Data = Data() // Extra data for contract method
        let contract = web3.contract(contractABI, at: contractAddress, abiVersion: abiVersion)
        
        if(contract != nil){
            print("nampv_contract")
        }
        
        let tx = contract?.read(
            contractMethod,
            parameters: parameters)!
        guard let result = try! tx?.call() else { return [:] }
        return result
    }
    
    /*@objc(initWeb3:)
    public func encode(_ function: String){
        let endpoint = "https://data-seed-prebsc-1-s1.binance.org:8545"
        web3x = web3(provider: Web3HttpProvider(URL(string: endpoint)!)!)
    }*/
    
    @objc public func signMessage(_mnemonics: String) ->  String {
        let _password = ""
        let keystore = try! BIP32Keystore(
            mnemonics: _mnemonics,
            password: _password,
            mnemonicsPassword: "",
            language: .english)!
        let name = "New HD Wallet"
        let keyData = try! JSONEncoder().encode(keystore.keystoreParams)
        let address = keystore.addresses!.first!.address
        let wallet = Wallet(address: address, data: keyData, name: name, isHD: true)
        
        let data = wallet.data
        let keystoreManager: KeystoreManager
        if wallet.isHD {
            let keystore = BIP32Keystore(data)!
            keystoreManager = KeystoreManager([keystore])
        } else {
            let keystore = EthereumKeystoreV3(data)!
            keystoreManager = KeystoreManager([keystore])
        }
        
        let web3 = web3(provider: Web3HttpProvider(URL(string: "https://data-seed-prebsc-1-s1.binance.org:8545")!)!)
        web3.addKeystoreManager(keystoreManager)
        
        
        let msgStr = "chainverse";
        let data1 = msgStr.data(using: .utf8)
        let signMsg = try! web3.wallet.signPersonalMessage(data1!, account: keystoreManager.addresses![0]);
        print(signMsg);
        return signMsg.toHexString();

    }
}
