//
//  CVWeb3.swift
//  Chainverse-SDK
//
//  Created by pham nam on 08/12/2021.
//


import Foundation
import BigInt
import UIKit
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
    
    public var _web3client: web3?
    public var _cvwallet: CVWallet?
    public var _password: String = ""
    public var _DEBUG: Bool = false
    @objc public func initWeb3(endpoint: String){
        _cvwallet = CVWallet()
        _web3client = web3(provider: Web3HttpProvider(URL(string: endpoint)!)!)
    }
    
    private func getMnemonic() -> String{
        return UserDefaults.standard.string(forKey: "CHAINVERSE_SDK_KEY_4")!
    }
    private func setKeystoreManager(){
        _web3client!.addKeystoreManager(_cvwallet!.getKeystoreManager(_mnemonics: getMnemonic()))
    }
    
    @objc public func getBalance(address: String) -> String {
        let walletAddress = EthereumAddress(address)!
        
        guard let balanceResult = try? _web3client!.eth.getBalance(address: walletAddress) else{
            return "0"
        }
        let balanceString = Web3.Utils.formatToEthereumUnits(balanceResult, toUnits: .eth, decimals: 3)!
        return balanceString
    }
    
    @objc public func isAddress(address : String) -> Bool {
        let address =  EthereumAddress(address)
        return ((address?.isValid) != nil)
    }
    
    @objc public func getBalanceToken(contractAddress : String ,owner: String) -> String {
        let contract = _web3client!.contract(Web3.Utils.erc20ABI, at: EthereumAddress(contractAddress), abiVersion: 2)!
        var options = TransactionOptions.defaultOptions
        options.gasPrice = .automatic
        options.gasLimit = .automatic
        let method = "balanceOf"
        let tx = contract.read(
            method,
            parameters: [EthereumAddress(owner)] as [AnyObject],
            extraData: Data(),
            transactionOptions: options)!
        
        guard let tokenBalance = try? tx.call() else{
            return "0"
        }
        
        let balanceBigUInt = tokenBalance["0"] as! BigUInt
        let balanceString = Web3.Utils.formatToEthereumUnits(balanceBigUInt, toUnits: .eth, decimals: 10)!
        return balanceString
    }
    
    private func isChecked(result : Int) -> Bool {
        if(result == 1){
            return true
        }
        return false
    }
    
    @objc public func isDeveloperContract(address: String, abi: String) ->  Bool {
        let contract = _web3client!.contract(abi, at: EthereumAddress(address), abiVersion: 2)!
        var options = TransactionOptions.defaultOptions
        options.gasPrice = .automatic
        options.gasLimit = .automatic
        let tx = contract.read(
            "isDeveloperContract",
            parameters: [] as [AnyObject],
            extraData: Data(),
            transactionOptions: options)!
        let result = try! tx.call()
        let data: Int? = result["0"] as? Int
        return isChecked(result: data!)
    }
    
    @objc public func isGameContract(address: String, abi: String) ->  Bool {
        let contract = _web3client!.contract(abi, at: EthereumAddress(address), abiVersion: 2)!
        var options = TransactionOptions.defaultOptions
        options.gasPrice = .automatic
        options.gasLimit = .automatic
        let tx = contract.read(
            "isGameContract",
            parameters: [] as [AnyObject],
            extraData: Data(),
            transactionOptions: options)!
        let result = try! tx.call()
        let data: Int? = result["0"] as? Int
        return isChecked(result: data!)
    }
    
    @objc public func isGamePaused(contractAddress: String, abi: String, gameAddress: String) ->  Bool {
        let contract = _web3client!.contract(abi, at: EthereumAddress(contractAddress), abiVersion: 2)!
        var options = TransactionOptions.defaultOptions
        options.gasPrice = .automatic
        options.gasLimit = .automatic
        let tx = contract.read(
            "isGamePaused",
            parameters: [EthereumAddress(gameAddress)] as [AnyObject],
            extraData: Data(),
            transactionOptions: options)!
        let result = try! tx.call()
        let data: Int? = result["0"] as? Int
        return isChecked(result: data!)
    }
    
    @objc public func isDeveloperPaused(contractAddress: String, abi: String, gameAddress: String) ->  Bool {
        let contract = _web3client!.contract(abi, at: EthereumAddress(contractAddress), abiVersion: 2)!
        var options = TransactionOptions.defaultOptions
        options.gasPrice = .automatic
        options.gasLimit = .automatic
        let tx = contract.read(
            "isDeveloperPaused",
            parameters: [EthereumAddress(gameAddress)] as [AnyObject],
            extraData: Data(),
            transactionOptions: options)!
        let result = try! tx.call()
        let data: Int? = result["0"] as? Int
        return isChecked(result: data!)
    }
    
   
    @objc public func signMessage(message: String) ->  String {
        let wallet = _cvwallet!.getWallet(_mnemonics: getMnemonic())
        let address = _cvwallet!.getAddress(_mnemonics: getMnemonic())
        let data = wallet.data
        let keystore = BIP32Keystore(data)!
        let signature = try! Web3Signer.signMessage(Data(message.utf8), keystore: keystore, account: EthereumAddress(address)!, password: "", useExtraEntropy: false)
        let signed = signature?.toHexString();
        return signed!;

    }
    
    @objc public func signPersonalMessage(message: String) ->  String {
        let wallet = _cvwallet!.getWallet(_mnemonics: getMnemonic())
        let address = _cvwallet!.getAddress(_mnemonics: getMnemonic())
        let data = wallet.data
        let keystore = BIP32Keystore(data)!
        let signature = try! Web3Signer.signPersonalMessage(Data(message.utf8), keystore: keystore, account: EthereumAddress(address)!, password: "", useExtraEntropy: false)
        let signed = signature?.toHexString();
        return signed!;

    }
    
    @objc public func signTransaction(nonce :String,gasPrice :String,gasLimit :String,toAddress :String,value :String,chainID :String,templateData :Data) ->  String {
        let amount = Web3.Utils.parseToBigUInt(value, units: .eth)
        let cvWallet = CVWallet()
        var transaction = EthereumTransaction(nonce: BigUInt(nonce)!,
                                                  gasPrice: BigUInt(gasPrice)!,
                                                  gasLimit: BigUInt(gasLimit)!,
                                                  to: EthereumAddress(toAddress)!,
                                                  value: amount!,
                                                  data: templateData,
                                                  v: BigUInt(0),
                                                  r: BigUInt(0),
                                                  s: BigUInt(0))
        transaction.UNSAFE_setChainID(BigUInt(chainID)!)
        print(transaction)
        try! Web3Signer.EIP155Signer.sign(transaction: &transaction, privateKey: cvWallet.getPrivateKeyData(_mnemonics: getMnemonic()), useExtraEntropy: false)
        let encoded:Data? = transaction.encode()
        return encoded!.toHexString()
    }
    
    //----Buy NFT----
    private func writeTXBuyNFT(marketService: String, abi: String,walletAddress: String, currency: String, listingId: Int, price: String, estimateGas: BigUInt) -> WriteTransaction {
        setKeystoreManager()
        let contract = _web3client!.contract(abi, at: EthereumAddress(marketService)!, abiVersion: 2)!
        let amount = Web3.Utils.parseToBigUInt(price, units: .eth)
        let parameters: [AnyObject] = [BigUInt(listingId),amount!] as [AnyObject]
        var options = TransactionOptions.defaultOptions
        if(currency.lowercased() == "0x0000000000000000000000000000000000000000".lowercased()){
            options.value = amount
        }
        options.from = EthereumAddress(walletAddress)!
        options.gasPrice = .automatic
        if(estimateGas == 0){
            options.gasLimit = .automatic
        }else{
            options.gasLimit = .manual(estimateGas)
        }
        let tx = contract.write(
            "buy",
            parameters: parameters,
            extraData: Data(),
            transactionOptions: options)!
        return tx
    }
    
    private func gasEstimateBuyNFT(marketService: String, abi: String,walletAddress: String, currency: String, listingId: Int, price: String) -> BigUInt {
        let tx = writeTXBuyNFT(marketService: marketService, abi: abi, walletAddress: walletAddress, currency: currency, listingId: listingId, price: price, estimateGas: 0)
        
        if(_DEBUG){
            _ = try! tx.estimateGasPromise().wait()
        }else{
            guard let estimate = try? tx.estimateGasPromise().wait() else {
                return 0
            }
            return estimate
        }
        return 0
    }
    
    @objc public func buyNFT(marketService: String, abi: String,walletAddress: String, currency: String, listingId: Int, price: String) -> String {
        let estimate = gasEstimateBuyNFT(marketService: marketService, abi: abi, walletAddress: walletAddress, currency: currency, listingId: listingId, price: price)
        if(estimate == 0){
            return "0x"
        }
        
        let tx = writeTXBuyNFT(marketService: marketService, abi: abi, walletAddress: walletAddress, currency: currency, listingId: listingId, price: price, estimateGas: estimate)
        guard let result = try? tx.send(password: _password) else {
            return "0x"
        }
        
        return result.transaction.txhash!
    }
    
    
    @objc public func feeBuyNFT(marketService: String, abi: String,walletAddress: String, currency: String, listingId: Int, price: String) -> String {
        let estimate = gasEstimateBuyNFT(marketService: marketService, abi: abi, walletAddress: walletAddress, currency: currency, listingId: listingId, price: price)
        if(estimate == 0){
            return "0x"
        }
        
        let gasPrice = try! _web3client!.eth.getGasPrice()
        let tmp = gasPrice * estimate
        let fees = Web3.Utils.formatToEthereumUnits(tmp , toUnits: .eth, decimals: 10)!
        print ("nampv_gasPrice3 \(tmp).")
        return fees
        
    }
    //----End Buy NFT----
    
    @objc public func bidNFT(marketService: String, abi: String,walletAddress: String, currency: String, listingId: Int, price: String) -> String{
        setKeystoreManager()
        let contract = _web3client!.contract(abi, at: EthereumAddress(marketService)!, abiVersion: 2)!
        let amount = Web3.Utils.parseToBigUInt(price, units: .eth)
        let parameters: [AnyObject] = [BigUInt(listingId),amount!] as [AnyObject]
        var options = TransactionOptions.defaultOptions
        options.from = EthereumAddress(walletAddress)!
        options.gasPrice = .automatic
        options.gasLimit = .automatic
        let tx = contract.write(
            "bid",
            parameters: parameters,
            extraData: Data(),
            transactionOptions: options)!
        guard let result = try? tx.send(password: _password) else {
            return ""
        }
        return result.transaction.txhash!
    }
    
    //---Approve Token----
    private func writeTXApproveToken(walletAddress: String, token: String, spender: String, value: String) -> WriteTransaction{
        setKeystoreManager()
        let contract = _web3client!.contract(Web3.Utils.erc20ABI, at: EthereumAddress(token)!, abiVersion: 2)!
        let amount = Web3.Utils.parseToBigUInt(value, units: .eth)
        let parameters: [AnyObject] = [EthereumAddress(spender)!, amount!] as [AnyObject]
        var options = TransactionOptions.defaultOptions
        options.from = EthereumAddress(walletAddress)
        options.gasPrice = .automatic
        options.gasLimit = .automatic
        let tx = contract.write(
            "approve",
            parameters: parameters,
            extraData: Data(),
            transactionOptions: options)!
        return tx
    }
    
    private func gasEstimateApproveToken(walletAddress: String, token: String, spender: String, value: String) -> BigUInt {
        let tx = writeTXApproveToken(walletAddress: walletAddress, token: token, spender: spender, value: value)
        
        if(_DEBUG){
            _ = try! tx.estimateGasPromise().wait()
        }else{
            guard let estimate = try? tx.estimateGasPromise().wait() else {
                return 0
            }
            return estimate
        }
        return 0
    }
    
    @objc public func approveToken(walletAddress: String, token: String, spender: String, value: String) -> String{
        let estimate = gasEstimateApproveToken(walletAddress: walletAddress, token: token, spender: spender, value: value)
        if(estimate == 0){
            return "0x"
        }
        
        let tx = writeTXApproveToken(walletAddress: walletAddress, token: token, spender: spender, value: value)
        guard let result = try? tx.send(password: _password) else {
            return "0x"
        }
        
        return result.transaction.txhash!
    }
    
    @objc public func feeApproveToken(walletAddress: String, token: String, spender: String, value: String) -> String {
        let estimate = gasEstimateApproveToken(walletAddress: walletAddress, token: token, spender: spender, value: value)
        if(estimate == 0){
            return "0x"
        }
        
        let gasPrice = try! _web3client!.eth.getGasPrice()
        let tmp = gasPrice * estimate
        let fees = Web3.Utils.formatToEthereumUnits(tmp , toUnits: .eth, decimals: 10)!
        print ("nampv_gasPrice3 \(tmp).")
        return fees
        
    }
    
    //---End Approve Token----
    private func getConnectType() -> String {
        return UserDefaults.standard.string(forKey: "CHAINVERSE_SDK_KEY_3")!
    }
    
    //----Approve NFT----
    private func writeTXApproveNFT(service: String, abi: String,walletAddress: String, nft: String, tokenId: Int) -> WriteTransaction{
        setKeystoreManager()
        let contract = _web3client!.contract(abi, at: EthereumAddress(nft)!, abiVersion: 2)!
        let tokenId = BigUInt(tokenId)
        let parameters: [AnyObject] = [EthereumAddress(service)!, tokenId] as [AnyObject]
        var options = TransactionOptions.defaultOptions
        options.from = EthereumAddress(walletAddress)
        options.gasPrice = .automatic
        options.gasLimit = .automatic
        let tx = contract.write(
            "approve",
            parameters: parameters,
            extraData: Data(),
            transactionOptions: options)!
        return tx
    }
    
    private func gasEstimateApproveNFT(service: String, abi: String,walletAddress: String, nft: String, tokenId: Int) -> BigUInt {
        let tx = writeTXApproveNFT(service: service, abi: abi, walletAddress: walletAddress, nft: nft, tokenId: tokenId)
        
        if(_DEBUG){
            _ = try! tx.estimateGasPromise().wait()
        }else{
            guard let estimate = try? tx.estimateGasPromise().wait() else {
                return 0
            }
            return estimate
        }
        return 0
    }
    
    @objc public func approveNFT(service: String, abi: String,walletAddress: String, nft: String, tokenId: Int) -> String{
        let estimate = gasEstimateApproveNFT(service: service, abi: abi, walletAddress: walletAddress, nft: nft, tokenId: tokenId)
        if(estimate == 0){
            return "0x"
        }
        
        let tx = writeTXApproveNFT(service: service, abi: abi, walletAddress: walletAddress, nft: nft, tokenId: tokenId)
        guard let result = try? tx.send(password: _password) else {
            return "0x"
        }
        
        return result.transaction.txhash!
        
    }
    
    @objc public func feeApproveNFT(service: String, abi: String,walletAddress: String, nft: String, tokenId: Int) -> String {
        let estimate = gasEstimateApproveNFT(service: service, abi: abi, walletAddress: walletAddress, nft: nft, tokenId: tokenId)
        if(estimate == 0){
            return "0x"
        }
        
        let gasPrice = try! _web3client!.eth.getGasPrice()
        let tmp = gasPrice * estimate
        let fees = Web3.Utils.formatToEthereumUnits(tmp , toUnits: .eth, decimals: 10)!
        return fees
        
    }
    
    //----End Approve NFT----
    
    /*@objc public func approveNFT(service: String, abi: String,walletAddress: String, nft: String, tokenId: Int) -> String{
        if(getConnectType() == "ChainverseSDK"){
            setKeystoreManager()
        }
        
        let contract = _web3client!.contract(abi, at: EthereumAddress(nft)!, abiVersion: 2)!
        let tokenId = BigUInt(tokenId)
        let parameters: [AnyObject] = [EthereumAddress(service)!, tokenId] as [AnyObject]
        var options = TransactionOptions.defaultOptions
        options.from = EthereumAddress(walletAddress)
        options.gasPrice = .automatic
        options.gasLimit = .automatic
        
        if(getConnectType() == "ChainverseSDK"){
            let tx = contract.write(
                "approve",
                parameters: parameters,
                extraData: Data(),
                transactionOptions: options)!
            guard let result = try? tx.send(password: _password) else {
                return ""
            }
            return result.transaction.txhash!
        }else{
            let encodeFunction = contract.encodeFunction(
                "approve",
                parameters: parameters,
                extraData: Data(),
                transactionOptions: options
            )
            print ("nampv_encodefunction2 \(encodeFunction).")
            sendTransaction(action: "approveNFT", to: nft, from: walletAddress, data: encodeFunction, value: "0", gasLimit: "100000", gasPrice: "10000000", nonce: "10000")
        }
        return ""
    }*/
    
    private func sendTransaction(action: String, to: String ,from: String, data: String, value: String, gasLimit: String, gasPrice: String, nonce: String) -> Void {
        var components = URLComponents()
        components.scheme = "chainverse"
        components.host = "sdk_transaction"
        components.queryItems = [
            URLQueryItem(name: "action", value: action),
            URLQueryItem(name: "asset", value: "20000714"),
            URLQueryItem(name: "to", value: to),
            URLQueryItem(name: "from", value: from),
            URLQueryItem(name: "data", value: data),
            URLQueryItem(name: "amount", value: value),
            URLQueryItem(name: "nonce", value: nonce),
            URLQueryItem(name: "fee_price", value: gasPrice),
            URLQueryItem(name: "fee_limit", value: gasLimit),
            URLQueryItem(name: "app", value: gasLimit),
            URLQueryItem(name: "callback", value: "tx_callback"),
            URLQueryItem(name: "confirm_type", value: "send"),
            URLQueryItem(name: "id", value: "2"),
            URLQueryItem(name: "meta", value: "memo"),
        ]
        
        let url = components.url
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url!, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url!)
        }
    }
    
    //----Sell NFT----
    private func writeTXSellNFT(marketService: String, abi: String, walletAddress: String, nft: String, tokenId: Int, price: String, currency: String, estimateGas: BigUInt) -> WriteTransaction {
        setKeystoreManager()
        let contract = _web3client!.contract(abi, at: EthereumAddress(marketService)!, abiVersion: 2)!
        let amount = Web3.Utils.parseToBigUInt(price, units: .eth)
        let parameters: [AnyObject] = [EthereumAddress(nft)!,BigUInt(tokenId),amount!, EthereumAddress(currency)!] as [AnyObject]
        var options = TransactionOptions.defaultOptions
        options.from = EthereumAddress(walletAddress)!
        options.gasPrice = .automatic
        if(estimateGas == 0){
            options.gasLimit = .automatic
        }else{
            options.gasLimit = .manual(estimateGas)
        }
        let tx = contract.write(
            "list",
            parameters: parameters,
            extraData: Data(),
            transactionOptions: options)!
        return tx
    }
    
    private func gasEstimateSellNFT(marketService: String, abi: String, walletAddress: String, nft: String, tokenId: Int, price: String, currency: String) -> BigUInt {
        let tx = writeTXSellNFT(marketService: marketService, abi: abi, walletAddress: walletAddress, nft: nft, tokenId: tokenId, price: price, currency: currency,estimateGas: 0)
        if(_DEBUG){
            _ = try! tx.estimateGasPromise().wait()
        }else{
            guard let estimate = try? tx.estimateGasPromise().wait() else {
                return 0
            }
            return estimate
        }
        return 0
    }
    
    @objc public func sellNFT(marketService: String, abi: String, walletAddress: String, nft: String, tokenId: Int, price: String, currency: String) -> String {
        let estimate = gasEstimateSellNFT(marketService: marketService, abi: abi, walletAddress: walletAddress, nft: nft, tokenId: tokenId, price: price, currency: currency)
        if(estimate == 0){
            return "0x"
        }
        
        let tx = writeTXSellNFT(marketService: marketService, abi: abi, walletAddress: walletAddress, nft: nft, tokenId: tokenId, price: price, currency: currency,estimateGas: estimate)
        guard let result = try? tx.send(password: _password) else {
            return "0x"
        }
        return result.transaction.txhash!
    }
    
    @objc public func feeSellNFT(marketService: String, abi: String, walletAddress: String, nft: String, tokenId: Int, price: String, currency: String) -> String {
        let estimate = gasEstimateSellNFT(marketService: marketService, abi: abi, walletAddress: walletAddress, nft: nft, tokenId: tokenId, price: price, currency: currency)
        if(estimate == 0){
            return "0x"
        }
        
        let gasPrice = try! _web3client!.eth.getGasPrice()
        let tmp = gasPrice * estimate
        let fees = Web3.Utils.formatToEthereumUnits(tmp , toUnits: .eth, decimals: 10)!
        return fees
    }
    //----End Sell NFT----
    
    //----Cancel Sell NFT----
    private func writeTXCancelSellNFT(marketService: String, abi: String,walletAddress: String, listingId: Int, estimateGas: BigUInt) -> WriteTransaction {
        setKeystoreManager()
        let contract = _web3client!.contract(abi, at: EthereumAddress(marketService)!, abiVersion: 2)!
        let parameters: [AnyObject] = [BigUInt(listingId)] as [AnyObject]
        var options = TransactionOptions.defaultOptions
        options.from = EthereumAddress(walletAddress)!
        options.gasPrice = .automatic
        if(estimateGas == 0){
            options.gasLimit = .automatic
        }else{
            options.gasLimit = .manual(estimateGas)
        }
        let tx = contract.write(
            "unList",
            parameters: parameters,
            extraData: Data(),
            transactionOptions: options)!
        return tx
    }
    
    private func gasEstimateCancelSellNFT(marketService: String, abi: String,walletAddress: String, listingId: Int) -> BigUInt {
        let tx = writeTXCancelSellNFT(marketService: marketService, abi: abi, walletAddress: walletAddress, listingId: listingId, estimateGas: 0)
        if(_DEBUG){
            _ = try! tx.estimateGasPromise().wait()
        }else{
            guard let estimate = try? tx.estimateGasPromise().wait() else {
                return 0
            }
            return estimate
        }
        return 0
    }
    
    @objc public func cancelSellNFT(marketService: String, abi: String,walletAddress: String, listingId: Int) -> String {
        let estimate = gasEstimateCancelSellNFT(marketService: marketService, abi: abi, walletAddress: walletAddress, listingId: listingId)
        if(estimate == 0){
            return "0x"
        }
        
        let tx = writeTXCancelSellNFT(marketService: marketService, abi: abi, walletAddress: walletAddress, listingId: listingId, estimateGas: estimate)
        guard let result = try? tx.send(password: _password) else {
            return ""
        }
        return result.transaction.txhash!
    }
    
    //----End Cancel Sell NFT----
    
    @objc public func isApproved(nft: String, tokenId: Int) -> String {
        setKeystoreManager()
        let contract = _web3client!.contract(Web3.Utils.erc721ABI, at: EthereumAddress(nft)!, abiVersion: 2)!
        var options = TransactionOptions.defaultOptions
        options.gasPrice = .automatic
        options.gasLimit = .automatic
        let tx = contract.read(
            "getApproved",
            parameters: [tokenId] as [AnyObject],
            extraData: Data(),
            transactionOptions: options)!
        
        let result = try! tx.call()
        let allowence: EthereumAddress? = result["0"] as? EthereumAddress
        return allowence!.address
    }
    
    @objc public func isApproved(token: String, owner: String, spender: String) -> String {
        setKeystoreManager()
        let contract = _web3client!.contract(Web3.Utils.erc20ABI, at: EthereumAddress(token)!, abiVersion: 2)!
        var options = TransactionOptions.defaultOptions
        options.gasPrice = .automatic
        options.gasLimit = .automatic
        let tx = contract.read(
            "allowance",
            parameters: [EthereumAddress(owner),EthereumAddress(spender)] as [AnyObject],
            extraData: Data(),
            transactionOptions: options)!
        
        let result = try! tx.call()
        let allowence = (result["0"] as? BigUInt)!
        
        let allowenceString = Web3.Utils.formatToEthereumUnits(allowence, toUnits: .eth, decimals: 10)!
        return allowenceString
    }
    
    //----Transfer Item----
    private func writeTxTransferItem(walletAddress: String, to: String, nft: String, tokenId: Int) -> WriteTransaction {
        setKeystoreManager()
        let from = EthereumAddress(walletAddress)!
        let contract = _web3client!.contract(Web3.Utils.erc721ABI, at: EthereumAddress(nft)!, abiVersion: 2)!
        let parameters: [AnyObject] = [from, EthereumAddress(to)!, tokenId] as [AnyObject]
        var options = TransactionOptions.defaultOptions
        options.from = from
        options.gasPrice = .automatic
        options.gasLimit = .automatic
        let tx = contract.write(
            "transferFrom",
            parameters: parameters,
            extraData: Data(),
            transactionOptions: options)!
        return tx
    }
    
    private func gasEstimateTransferItem(walletAddress: String, to: String, nft: String, tokenId: Int) -> BigUInt {
        let tx = writeTxTransferItem(walletAddress: walletAddress, to: to, nft: nft, tokenId: tokenId)
        if(_DEBUG){
            _ = try! tx.estimateGasPromise().wait()
        }else{
            guard let estimate = try? tx.estimateGasPromise().wait() else {
                return 0
            }
            return estimate
        }
        return 0
    }
    
    @objc public func transferItem(walletAddress: String, to: String, nft: String, tokenId: Int) -> String {
        let estimate = gasEstimateTransferItem(walletAddress: walletAddress, to: to, nft: nft, tokenId: tokenId)
        if(estimate == 0){
            return "0x"
        }
        
        let tx = writeTxTransferItem(walletAddress: walletAddress, to: to, nft: nft, tokenId: tokenId)
        guard let result = try? tx.send(password: _password) else {
            return ""
        }
        return result.transaction.txhash!
    }
    
    @objc public func feeTransferItem(walletAddress: String, to: String, nft: String, tokenId: Int) -> String {
        let estimate = gasEstimateTransferItem(walletAddress: walletAddress, to: to, nft: nft, tokenId: tokenId)
        if(estimate == 0){
            return "0x"
        }
        let gasPrice = try! _web3client!.eth.getGasPrice()
        let tmp = gasPrice * estimate
        let fees = Web3.Utils.formatToEthereumUnits(tmp , toUnits: .eth, decimals: 10)!
        return fees
    }
    //----End Transfer Item----
    
    @objc public func withdrawNFT(walletAddress: String,gameAddress: String,abi: String, nft: String, tokenId: Int) -> String {
        setKeystoreManager()
        let contract = _web3client!.contract(abi, at: EthereumAddress(gameAddress)!, abiVersion: 2)!
        let parameters: [AnyObject] = [EthereumAddress(nft)!, tokenId] as [AnyObject]
        var options = TransactionOptions.defaultOptions
        options.from = EthereumAddress(walletAddress)!
        options.gasPrice = .automatic
        options.gasLimit = .automatic
        let tx = contract.write(
            "withdrawItem",
            parameters: parameters,
            extraData: Data(),
            transactionOptions: options)!
        guard let result = try? tx.send(password: _password) else {
            return ""
        }
        return result.transaction.txhash!
    }
    
    @objc public func moveService(walletAddress: String, serviceAddress: String,abi: String, nft: String, tokenId: Int) -> String {
        setKeystoreManager()
        let contract = _web3client!.contract(abi, at: EthereumAddress(serviceAddress)!, abiVersion: 2)!
        let parameters: [AnyObject] = [EthereumAddress(nft)!, tokenId, EthereumAddress(serviceAddress)!] as [AnyObject]
        var options = TransactionOptions.defaultOptions
        options.from = EthereumAddress(walletAddress)!
        options.gasPrice = .automatic
        options.gasLimit = .automatic
        let tx = contract.write(
            "moveService",
            parameters: parameters,
            extraData: Data(),
            transactionOptions: options)!
        guard let result = try? tx.send(password: _password) else {
            return ""
        }
        return result.transaction.txhash!
    }
    
    
    @objc public func getByNFT(marketService: String, abi: String, nft: String, tokenId: Int) -> NSMutableDictionary {
        guard let contract = try? _web3client?.contract(abi, at: EthereumAddress(marketService)!, abiVersion: 2) else {
            return [
                "is_auction": "",
                "nft" : "",
                "owner" : "",
                "token_id" : "",
                "fee" : "",
                "price" : "",
                "listing_id": ""
            ]
        }
        var options = TransactionOptions.defaultOptions
        options.gasPrice = .automatic
        options.gasLimit = .automatic
        let tx = contract.read(
            "getByNFT",
            parameters: [EthereumAddress(nft)!, tokenId] as [AnyObject],
            extraData: Data(),
            transactionOptions: options)!
        
        let result = try! tx.call()
        /*let auction = result["auction"] as! Array<Any>
        let nftaddress = auction[1] as! EthereumAddress
        let winnerAddress = auction[2] as! EthereumAddress
        let ownerAddress = auction[3] as! EthereumAddress
        let currencyAddress = auction[4] as! EthereumAddress
        let TKID = auction[5]
        let fee = auction[6]
        let bid = auction[7]
        let bidDuration = auction[8]
        let end = auction[9]
        let listingId = auction[10]
        
        let dictParams: NSMutableDictionary? = [
            "is_ended": auction[0],
            "nft" : nftaddress.address,
            "winner" : winnerAddress.address,
            "owner" : ownerAddress.address,
            "currency" : currencyAddress.address,
            "token_id" : TKID,
            "price" : fee,
            "bid" : bid,
            "duration" : bidDuration,
            "end": end,
            "listing_id": listingId
        ]*/
        
        let listing = result["listing"] as! Array<Any>
        let nftaddress = listing[1] as! EthereumAddress
        let ownerAddress = listing[3] as! EthereumAddress
        let TKID = listing[4]
        let fee = listing[5]
        let price = listing[6]
        let listingId = listing[7]
        
        let dictParams: NSMutableDictionary? = [
            "is_auction": listing[0],
            "nft" : nftaddress.address,
            "owner" : ownerAddress.address,
            "token_id" : TKID,
            "fee" : fee,
            "price" : price,
            "listing_id": listingId
        ]
        return dictParams!;
    }
    
    @objc public func getTokenUri(nft: String, tokenId: Int) -> String {
        guard let contract = _web3client!.contract(Web3.Utils.erc721ABI, at: EthereumAddress(nft)!, abiVersion: 2) else {
            return ""
        }
        
        var options = TransactionOptions.defaultOptions
        options.gasPrice = .automatic
        options.gasLimit = .automatic
        let tx = contract.read(
            "tokenURI",
            parameters: [tokenId] as [AnyObject],
            extraData: Data(),
            transactionOptions: options)!
        
        let result = try! tx.call()
        let uri: String? = result["0"] as? String
        return uri!;
    }
    
    @objc public func getBlockNumber(rpc: String) -> Int{
        let url = URL(string: rpc)
        
        guard let web3Provider = Web3HttpProvider(url!) else {
          return 0
        }
        let web3client = web3(provider: web3Provider)
        
        guard let blockNumber = try? web3client.eth.getBlockNumber() else{
            return 0
        }
        return Int(blockNumber)
    }
    
    private func getNonce() -> BigUInt{
        let transactionCount = try! _web3client!.eth.getTransactionCount(address: EthereumAddress("0xFEAd320Bf517B4dd82b21374fD8bfA1Bb2c70f85")!)
        return transactionCount
    }
    
}
