//
//  Bridging.swift
//  Test
//
//  Created by Mac on 7/20/21.
//

import Foundation

// This protocol allows you to init objc class with its original swift class
public protocol SwiftContainer: SwiftBridgeable {
    init(_ swift: SwiftType)
}

public protocol SwiftBridgeable: SwiftBridgeableHack {
    associatedtype SwiftType
    var swift: SwiftType { get }
}

// This protocol allows you to get swift value as Any.
// Without this protocol .toSwift() function cannot convert Any to SwiftBridgeable
// because it contains associatedtype
public protocol SwiftBridgeableHack {
    var __swift: Any { get }
}
extension SwiftBridgeable {
    public var __swift: Any { return swift }
}
func toSwift(_ any: Any) -> Any {
    if let string = any as? String {
        return string
    } else if let objc = any as? SwiftBridgeableHack {
        return objc.__swift
    } else {
        return any
    }
}

extension Array where Element: Any {
    var swift: [Any] {
        return map(toSwift)
    }
}
