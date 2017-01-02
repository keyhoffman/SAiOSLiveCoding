//
//  Result.swift
//  SAiOS-FlickrViewerLiveCoding
//
//  Created by Key Hoffman on 1/2/17.
//  Copyright © 2017 Key Hoffman. All rights reserved.
//

import Foundation

// MARK: - Result

public enum Result<Value> {    
    case value(Value)
    case error(Error)
    
    public init(_ value: Value) { self = .value(value) }
    public init(_ error: Error) { self = .error(error) }
}

// MARK: - Initialization

public extension Result {
    public init(_ value: Value?, _ error: Error?) {
             if let value = value { self = .value(value) }
        else if let error = error { self = .error(error) }
        else { self = Result.init <| OptionalError.nonExistantValue(ofType: value) }
    }
    
    //    init(_ value: Value?, with fail: @autoclosure () -> Error) {
    //        self = value.map(Result.value) ?? .error(fail())
    //    }
}

// MARK: - Higher-Order Operations

public extension Result {
    public func flatMap<U>(_ f: (Value) -> Result<U>) -> Result<U> {
        switch self {
        case let .error(error): return .error(error)
        case let .value(value): return f(value)
        }
    }
    
    public func map<U>(_ f: @escaping (Value) -> U) -> Result<U> {
        return flatMap { .value(f($0)) }
    }
    
    public func apply<U>(_ f: Result<(Value) -> U>) -> Result<U> {
        return f.flatMap { self.map($0) }
    }
}

// MARK: - Optional Interoperability

public extension Result {
    public var toOptional: Value? {
        switch self {
        case .error:            return nil
        case .value(let value): return value
        }
    }
}

// MARK: - Equatable Conformance (but not really)

public func == <T>(_ lhs: Result<T>, _ rhs: Result<T>) -> Bool where T: Equatable {
    switch (lhs, rhs) {
    case let (.value(v1), .value(v2)): return v1 == v2
    default:                           return false
    }
}

public func != <T>(_ lhs: Result<T>, _ rhs: Result<T>) -> Bool where T: Equatable {
    return !(lhs == rhs)
}

// MARK: - Comparable Conformance (but not really)

public func > <T>(_ lhs: Result<T>, _ rhs: Result<T>) -> Bool where T: Comparable {
    switch (lhs, rhs) {
    case let (.value(lv), .value(rv)): return lv > rv
    default:                           return false
    }
}

public func < <T>(_ lhs: Result<T>, _ rhs: Result<T>) -> Bool where T: Comparable {
    switch (lhs, rhs) {
    case let (.value(lv), .value(rv)): return lv < rv
    default:                           return false
    }
}

public func >= <T>(_ lhs: Result<T>, _ rhs: Result<T>) -> Bool where T: Comparable {
    switch (lhs, rhs) {
    case let (.value(lv), .value(rv)): return lv >= rv
    default:                           return false
    }
}

public func <= <T>(_ lhs: Result<T>, _ rhs: Result<T>) -> Bool where T: Comparable {
    switch (lhs, rhs) {
    case let (.value(lv), .value(rv)): return lv <= rv
    default:                           return false
    }
}
