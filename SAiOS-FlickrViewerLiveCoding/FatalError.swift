//
//  FatalError.swift
//  SAiOS-FlickrViewerLiveCoding
//
//  Created by Key Hoffman on 1/2/17.
//  Copyright © 2017 Key Hoffman. All rights reserved.
//

import Foundation

// MARK: - FatalError

enum FatalError: Error, CustomDebugStringConvertible {
    case couldNotDequeueCell(identifier: String)
    case couldNotUnwrapResult
}

// MARK: - CustomDebugStringConvertible Conformance

extension FatalError {
    var debugDescription: String {
        switch self {
        case .couldNotDequeueCell(let id): return "Failed to dequeue resuable cell with identifier:" + id
        case .couldNotUnwrapResult:        return "Attempted to unwrap a Result"
        }
    }
}
