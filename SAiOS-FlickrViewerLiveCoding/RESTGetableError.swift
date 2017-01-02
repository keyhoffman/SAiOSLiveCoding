//
//  RESTGetableError.swift
//  SAiOS-FlickrViewerLiveCoding
//
//  Created by Key Hoffman on 1/2/17.
//  Copyright © 2017 Key Hoffman. All rights reserved.
//

import Foundation

// MARK: - RESTGetableError

enum RESTGetableError: Error, CustomStringConvertible {
    case invalidURL(parameters: URLParameters)
    case invalidURLPath(path: String?)
    case invalidResponseStatus(code: Int)
    case couldNotParseJSON
}

// MARK: - CustomStringConvertible Conformance

extension RESTGetableError {
    var description: String {
        switch self {
        case .invalidURL(_):                   return "Invalid URL Request"
        case .invalidURLPath(let path):        return "Invalid URL Path:\n" + String(describing: path)
        case .invalidResponseStatus(let code): return "Invalid Response Code:\n" + String(code)
        case .couldNotParseJSON:               return "Invalid data"
        }
    }
}
