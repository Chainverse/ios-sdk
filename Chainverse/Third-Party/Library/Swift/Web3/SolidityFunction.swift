//
//  SolidityFunction.swift
//  Test
//
//  Created by Mac on 7/20/21.
//

import Foundation

public class SolidityFunction: CustomStringConvertible {
    /// Errors
    public enum Error: Swift.Error {
        /// Throws if function is in invalid format
        case invalidFormat(String)
        /// Throws if function name is empty
        case emptyFunctionName(String)
        /// Printable / user displayable description
        public var localizedDescription: String {
            switch self {
            case let .invalidFormat(function):
                return "Invalid format for function \"\(function)\". Should be in format: \"functionName(type,type,type)\""
            case let .emptyFunctionName(function):
                return "Invalid format for function \"\(function)\". Cannot find its name"
            }
        }
    }
    /// Function name
    public let name: String
    /// Array of function arguments
    public let types: [SolidityType]
    /// Formatted function
    public let function: String
    /// Function hash (function.keccak256()[0..<4])
    public lazy var hash: Data = self.function.keccak256()[0..<4]
    /// init with function name
    public init(function: String) throws {
        let replaced = function.replacingOccurrences(of: " ", with: "")
        guard let index = replaced.index(of: "(") else { throw Error.invalidFormat(function) }
        name = String(replaced[..<index])
        guard name.count > 0 else { throw Error.emptyFunctionName(function) }
        guard replaced.hasSuffix(")") else { throw Error.invalidFormat(function) }
        let arguments = replaced[replaced.index(after: index)..<replaced.index(before: replaced.endIndex)]
        self.types = try arguments.split(separator: ",").map { try SolidityType.scan(type: String($0)) }
        self.function = "\(name)(\(types.map { $0.description }.joined(separator: ",")))"
    }
    /// Encodes arguments to data
    public func encode(_ arguments: SolidityDataRepresentable...) -> Data {
        return encode(arguments)
    }
    /// Encodes arguments to data
    public func encode(_ arguments: [SolidityDataRepresentable]) -> Data {
        let data = SolidityDataWriter()
        data.write(header: hash)
        for i in 0..<types.count {
            let type = types[i]
            if i < arguments.count {
                data.write(value: arguments[i], type: type)
            } else {
                data.write(type: type)
            }
        }
        return data.done()
    }
    /// Description in format: "\(name)(\(types.map{ $0.description }.joined(separator: ",")))"
    public var description: String {
        return "\(name)(\(types.map{ $0.description }.joined(separator: ",")))"
    }
}
