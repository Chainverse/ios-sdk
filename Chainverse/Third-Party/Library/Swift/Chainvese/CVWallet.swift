//
//  Wallet.swift
//  Chainverse-SDK
//
//  Created by pham nam on 29/11/2021.
//

import Foundation
import BigInt
@objc public class CVWallet: NSObject{
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
    public var _password: String = ""
    @objc public func initialize(){
        
    }
    
    @objc public func genMnemonic(bitsOfEntropy: Int) -> String {
        let tempMnemonics = try? BIP39.generateMnemonics(bitsOfEntropy: bitsOfEntropy, language: .english)
        guard let tMnemonics = tempMnemonics else {
            return ""
        }
        let mnemonnics = tMnemonics;
        return mnemonnics;
    }
    
    
    
    @objc public func importWalletWith(_mnemonics: String) -> String {
        guard let keystore = try? BIP32Keystore(
            mnemonics: _mnemonics,
            password: _password,
            mnemonicsPassword: "",
            language: .english) else{
                return ""
            }
        let address = keystore.addresses!.first!.address
        return address
    }
    
    func getPrivateKeyData(_mnemonics: String) -> Data {
        let _password = ""
        let wallet = getWallet(_mnemonics: _mnemonics)
        
        let data = wallet.data
        let keystoreManager: KeystoreManager
        if wallet.isHD {
            let keystore = BIP32Keystore(data)!
            keystoreManager = KeystoreManager([keystore])
        } else {
            let keystore = EthereumKeystoreV3(data)!
            keystoreManager = KeystoreManager([keystore])
        }
        
        let ethereumAddress = EthereumAddress(wallet.address)!
        let pkData = try! keystoreManager.UNSAFE_getPrivateKeyData(password: _password, account: ethereumAddress)
        return pkData
    }
    
    @objc public func getPrivateKey(_mnemonics: String) -> String {
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
        
        let ethereumAddress = EthereumAddress(wallet.address)!
        let pkData = try! keystoreManager.UNSAFE_getPrivateKeyData(password: _password, account: ethereumAddress).toHexString()
        return pkData
    }
    
    func getWallet(_mnemonics: String) -> Wallet {
        let keystore = try! BIP32Keystore(
            mnemonics: _mnemonics,
            password: _password,
            mnemonicsPassword: "",
            language: .english)!
        let name = "New HD Wallet"
        let keyData = try! JSONEncoder().encode(keystore.keystoreParams)
        let address = keystore.addresses!.first!.address
        let wallet = Wallet(address: address, data: keyData, name: name, isHD: true)
        return wallet
    }
    
    func getKeystoreManager(_mnemonics: String) -> KeystoreManager{
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
        return keystoreManager
    }
    func getAddress(_mnemonics: String) -> String{
        let keystore = try! BIP32Keystore(
            mnemonics: _mnemonics,
            password: _password,
            mnemonicsPassword: "",
            language: .english)!
        let address = keystore.addresses!.first!.address
        return address;
    }
}
