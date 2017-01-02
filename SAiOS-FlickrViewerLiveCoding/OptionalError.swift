//
//  OptionalError.swift
//  SAiOS-FlickrViewerLiveCoding
//
//  Created by Key Hoffman on 1/2/17.
//  Copyright © 2017 Key Hoffman. All rights reserved.
//

import Foundation

// MARK: - OptionalError

internal enum OptionalError<T>: Error, CustomDebugStringConvertible {
    case nonExistantValue(ofType: T)
}

// MARK: - CustomStringConvertible Conformance

internal extension OptionalError {
    var description: String {
        switch self {
        case let .nonExistantValue(value): return "Error: No value exists for" + String(describing: value)
        }
    }
}

// MARK: - CustomDebugStringConvertible Conformance

internal extension OptionalError {
    var debugDescription: String {
        switch self {
        case .nonExistantValue: return "ERROR:" + description
        }
    }
}
