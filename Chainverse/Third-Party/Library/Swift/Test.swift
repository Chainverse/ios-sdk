//
//  Test.swift
//  Chainverse-SDK
//
//  Created by pham nam on 14/07/2021.
//

import Foundation
import CryptoSwift
@objc public class TestSwift : NSObject {
    public var testProperty: Any = "Some Initializer Val"
    
    
    override init() {}
    @objc(testsFunction:)
    public  func testsFunction(someArg:AnyObject)  {
    let returnVal = "You sent me \(someArg)"
    print(returnVal)


    }
    
    @objc(keccak256)
    public func keccak256() -> String {
        let data = Data("nampv".utf8)
        return data.sha3(.keccak256).hex
    }
    
    @objc(test)
    public func test() -> String {
        let function = try! SolidityFunction(function: "isDeveloperContract()")
        let data = function.encode([] as! [SolidityDataRepresentable])
        let hex = data.hex.withHex.lowercased()
        return hex
    }
}
