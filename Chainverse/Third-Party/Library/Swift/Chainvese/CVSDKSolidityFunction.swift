//
//  ObjcSolidityFunction.swift
//  Chainverse-SDK
//
//  Created by pham nam on 15/07/2021.
//

import Foundation

@objc public class CVSDKSolidityFunction : NSObject {
    override init() {}
    
    @objc(encode::)
    public func encode(_ function: String, _ address: String) -> String {
        let address = Address(address)
        let params = [address]
        
        let function = try! SolidityFunction(function: function)
        let data = function.encode(params.swift as! [SolidityDataRepresentable])
        let hex = data.hex.withHex.lowercased()
        return hex
    }
}
