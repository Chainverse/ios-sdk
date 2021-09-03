//
//  SolidityType.swift
//  Test
//
//  Created by Mac on 7/20/21.
//

import Foundation

public class SolidityType: Equatable, CustomStringConvertible {
    static let uint256 = SUInt(bits: 256)
    static let address = SAddress()
    
    
    /// SolidityType array size
    public enum ArraySize {
        /// returns number of elements in a static array
        case `static`(Int)
        /// dynamic array
        case dynamic
        /// for non array types
        case notArray
    }
    /// returns true if type is static (not not uses data pointer in abi). default: true
    public var isStatic: Bool { return true }
    /// returns true if type is array. default: false
    public var isArray: Bool { return false }
    /// returns true if type is tuple. default: false
    /// - Important: tuples are not supported at this moment
    public var isTuple: Bool { return false }
    /// returns number of elements in array if it static. default: .notArray
    public var arraySize: ArraySize { return .notArray }
    /// returns type's subtype used in array types. default: nil
    public var subtype: SolidityType? { return nil }
    /// returns type memory usage. default: 32
    public var memoryUsage: Int { return 32 }
    /// returns default data for empty value. default: Data(repeating: 0, count: memoryUsage)
    public var `default`: Data { return Data(count: memoryUsage) }
    /// - Returns string representation of solidity type
    public var description: String { return "" }
    /// returns true if type input parameters is valid: default true
    public var isValid: Bool { return true }
    /// returns true if type is supported in web3swift
    public var isSupported: Bool { return true }
    
    public static func == (lhs: SolidityType, rhs: SolidityType) -> Bool {
        return lhs.description == rhs.description
    }
    
    /// Type conversion error
    public enum Error: Swift.Error {
        /// Unknown solidity type "\(string)"
        case corrupted(String)
        /// Printable / user displayable description
        public var localizedDescription: String {
            switch self {
            case let .corrupted(string):
                return "Unknown solidity type: \"\(string)\""
            }
        }
    }
    
    /// Represents solidity uintN type
    public class SUInt: SolidityType {
        var bits: Int
        init(bits: Int) {
            self.bits = bits
            super.init()
        }
        public override var description: String { return "uint\(bits)" }
        public override var isValid: Bool {
            return (8...256).contains(bits) && (bits & 0b111 == 0)
        }
    }
    
    /// Represents solidity intN type
    public class SInt: SUInt {
        public override var description: String { return "int\(bits)" }
    }
    
    /// Represents solidity address type
    public class SAddress: SolidityType {
        public override var description: String { return "address" }
    }
    
    /// Unsupported
    public class SFunction: SolidityType {
        public override var description: String { return "function" }
        public override var isSupported: Bool { return false }
    }
    
    /// Represents solidity bool type
    public class SBool: SolidityType {
        public override var description: String { return "bool" }
    }
    
    /// Represents solidity bytes[N] type
    public class SBytes: SolidityType {
        public override var description: String { return "bytes\(count)" }
        public override var isValid: Bool { return count > 0 && count <= 32 }
        var count: Int
        init(count: Int) {
            self.count = count
            super.init()
        }
    }
    
    /// Represents solidity bool[] type
    public class SDynamicBytes: SolidityType {
        public override var description: String { return "bytes" }
        public override var memoryUsage: Int { return 0 }
        public override var isStatic: Bool { return false }
    }
    
    /// Represents solidity string type
    public class SString: SolidityType {
        public override var description: String { return "string" }
        public override var isStatic: Bool { return false }
        public override var memoryUsage: Int { return 0 }
    }
    
    /// Represents solidity type[N] type
    public class SStaticArray: SolidityType {
        public override var description: String { return "\(type)[\(count)]" }
        public override var isStatic: Bool { return type.isStatic }
        public override var isArray: Bool { return true }
        public override var subtype: SolidityType? { return type }
        public override var arraySize: ArraySize { return .static(count) }
        public override var isValid: Bool { return type.isValid }
        public override var memoryUsage: Int {
            return 32 * count
        }
        var count: Int
        var type: SolidityType
        init(count: Int, type: SolidityType) {
            self.count = count
            self.type = type
            super.init()
        }
    }
    
    /// Represents solidity type[] type
    public class SDynamicArray: SolidityType {
        public override var description: String { return "\(type)[]" }
        public override var memoryUsage: Int { return 0 }
        public override var isStatic: Bool { return false }
        public override var isArray: Bool { return true }
        public override var subtype: SolidityType? { return type }
        public override var arraySize: ArraySize { return .dynamic }
        public override var isValid: Bool { return type.isValid }
        var type: SolidityType
        init(type: SolidityType) {
            self.type = type
            super.init()
        }
    }
    
    /**
     Unsupported. But you can still parse it using
     ```
     let type = SolidityType.scan("tuple(uint256,uint256")
     ```
     */
    public class SolidityTuple: SolidityType {
        public override var description: String { return "tuple(\(types.map { $0.description }.joined(separator: ",")))" }
        public override var isStatic: Bool { return types.allSatisfy { $0.isStatic } }
        public override var isTuple: Bool { return true }
        public override var isSupported: Bool { return false }
        public override var memoryUsage: Int {
            guard isStatic else { return 32 }
            return types.reduce(0, { $0 + $1.memoryUsage })
        }
        public override var isValid: Bool { return types.allSatisfy { $0.isValid } }
        var types: [SolidityType]
        init(types: [SolidityType]) {
            self.types = types
            super.init()
        }
    }
}

// MARK:- String to SolidityType
extension SolidityType {
    private static var knownTypes: [String: SolidityType] = [
        "function": SFunction(),
        "address": SAddress(),
        "string": SString(),
        "bool": SBool(),
        "uint": SUInt(bits: 256),
        "int": SInt(bits: 256)
    ]
    private static func scan(tuple string: String, from index: Int) throws -> SolidityType {
        guard string.last! == ")" else { throw Error.corrupted(string) }
        guard string[..<index] == "tuple" else { throw Error.corrupted(string) }
        let string = string[index+1..<string.count-1]
        let array = try string.split(separator: ",").map { try scan(type: String($0)) }
        return SolidityTuple(types: array)
    }
    private static func scan(arraySize string: String, from index: Int) throws -> SolidityType {
        guard string.last! == "]" else { throw Error.corrupted(string) }
        let prefix = string[..<index]
        guard let type = knownTypes[String(prefix)] else { throw Error.corrupted(string) }
        // type.isValid == true
        let string = string[index+1..<string.count-1]
        if string.isEmpty {
            return SDynamicArray(type: type)
        } else {
            guard let count = Int(string) else { throw Error.corrupted(string) }
            guard count > 0 else { throw Error.corrupted(string) }
            return SStaticArray(count: count, type: type)
        }
    }
    private static func scan(bytesArray string: String, from index: Int) throws -> SolidityType {
        guard let count = Int(string[index...]) else { throw Error.corrupted(string) }
        let type = SBytes(count: count)
        guard type.isValid else { throw Error.corrupted(string) }
        return type
    }
    private static func scan(number string: String, from index: Int) throws -> SolidityType {
        let prefix = string[..<index]
        let isSigned: Bool
        switch prefix {
        case "uint":
            isSigned = false
        case "int":
            isSigned = true
        default: throw Error.corrupted(string)
        }
        let i = index+1
        for (index2,character) in string[i...].enumerated() {
            switch character {
            case "[":
                guard let number = Int(string[index...index+index2]) else { throw Error.corrupted(string) }
                let type = isSigned ? SInt(bits: number) : SUInt(bits: number)
                guard type.isValid else { throw Error.corrupted(string) }
                guard string.last! == "]" else { throw Error.corrupted(string) }
                // type.isValid == true
                let string = string[index+index2+2..<string.count-1]
                if string.isEmpty {
                    return SDynamicArray(type: type)
                } else {
                    guard let count = Int(string) else { throw Error.corrupted(string) }
                    guard count > 0 else { throw Error.corrupted(string) }
                    let array = SStaticArray(count: count, type: type)
                    guard array.isValid else { throw Error.corrupted(string) }
                    return array
                }
            case "0"..."9":
                guard index2 < 3 else { throw Error.corrupted(string) }
                continue
            default: throw Error.corrupted(string)
            }
        }
        guard let number = Int(string[index...]) else { throw Error.corrupted(string) }
        let type = isSigned ? SInt(bits: number) : SUInt(bits: number)
        guard type.isValid else { throw Error.corrupted(string) }
        return type
    }
    /**
     converts single solidity type to native type:
     SolidityFunction uses this method to parse the whole function to name and input types
     example:
     ```
     let type = try! SolidityType.parse("uint256")
     print(type) // prints uint256
     print(type is SolidityType.SUInt) // prints true
     print((type as! SolidityType.SUInt).bits) // prints 256
     ```
     */
    public static func scan(type string: String) throws -> SolidityType {
        for (index,character) in string.enumerated() {
            switch character {
            case "(":
                return try scan(tuple: string, from: index)
            case "[":
                return try scan(arraySize: string, from: index)
            case "0"..."9":
                let prefix = string[..<index]
                if prefix == "bytes" {
                    return try scan(bytesArray: string, from: index)
                } else {
                    return try scan(number: string, from: index)
                }
            default: continue
            }
        }
        if string == "bytes" {
            return SDynamicBytes()
        } else if let type = knownTypes[String(string)] {
            return type
        } else {
            throw Error.corrupted(string)
        }
    }
}

