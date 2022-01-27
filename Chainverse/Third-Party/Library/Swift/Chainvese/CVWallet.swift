//
//  Wallet.swift
//  Chainverse-SDK
//
//  Created by pham nam on 29/11/2021.
//

import Foundation
import web3swift
import BigInt
@objc public class CVWallet: NSObject{
    @objc public func createMnemonics(bitsOfEntropy: Int) -> String {
        let tempMnemonics = try? BIP39.generateMnemonics(bitsOfEntropy: bitsOfEntropy, language: .english)
        guard let tMnemonics = tempMnemonics else {
            return ""
        }
        let mnemonnics = tMnemonics;
        return mnemonnics;
    }
    
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
    
    @objc public func importWalletWith(mnemonics: String) -> String {
        do {
            let password = ""
            let keystore = try BIP32Keystore(
                mnemonics: mnemonics,
                password: password,
                mnemonicsPassword: "",
                language: .english)
            let address = keystore?.addresses!.first!.address
            return address ?? ""
        }catch {
            return ""
        }
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
    
    @objc public func signFuck(_mnemonics: String) -> String {
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
        
        let message = Web3.Utils.sha3("chainverse".data(using: .utf8)!)!
        let signature = try! Web3Signer.signPersonalMessage(Data("chainverse".utf8), keystore: keystore, account: EthereumAddress(address)!, password: _password)
        
        /*let rData = Data(signature![0..<32])
        let sData = Data(signature![32..<64])
        let vData = BigUInt(signature![64]) + BigUInt(27)*/
        
       
        let r = signature!.bytes[0..<32]
        let s = signature!.bytes[32..<64]
        let v = UInt8((signature![64] + 27))
        let signatureData = SECP256K1.UnmarshaledSignature.init(v: v, r: Data(r), s: Data(s))
        //let signatureData = SECP256K1.marshalSignature(v: Data([v]), r: Data(r), s: Data(s))!
        //return signatureData.toHexString().addHexPrefix()
        //signatureData.toHexString().addHexPrefix()
        
        let r1 = signatureData.r.toHexString().stripHexPrefix()
        let s1 = signatureData.s.toHexString().stripHexPrefix()
        let header = signatureData.v - 27 // recId has different formats in go and web3j/web3swift
        var v1: String
            if header < 10 {
                v1 = "0"
            } else {
                v1 = ""
            }
                
            v1.append(contentsOf: String(format: "%X", header))
                
            return r1 + s1 + v1
       
    }
    
    @objc public func signMessage(privateKey: String, msg: String) -> String {
        let message = Web3.Utils.sha3(msg.data(using: .utf8)!)
        let compressedSignature = SECP256K1.signForRecovery(hash: message!, privateKey: Data(hex: privateKey), useExtraEntropy: false)
        return (compressedSignature.rawSignature?.toHexString())!
    }
}
