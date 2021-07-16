//
//  ObjcSolidityFunction.swift
//  Chainverse-SDK
//
//  Created by pham nam on 15/07/2021.
//

import Foundation

@objc public class ObjcSolidityFunction : NSObject {
    override init() {}
    
    @objc(encode::)
    public func encode(_ function: String, _ arguments: [Any]) -> String {
        let function = try! SolidityFunction(function: function)
        let data = function.encode(arguments.swift as! [SolidityDataRepresentable])
        let hex = data.hex.withHex.lowercased()
        return hex
    }
}
