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
    
  
}
