//
//  CVSDKKeccak256.swift
//  Chainverse-SDK
//
//  Created by pham nam on 16/07/2021.
//

import Foundation

@objc public class CVSDKKeccak256 : NSObject {
    override init() {}
    @objc(keccak256:)
    public func keccak256(_ input: String) -> String {
        let data = Data(input.utf8)
        return data.sha3(.keccak256).hex
    }
}
