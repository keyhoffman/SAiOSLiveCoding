//
//  CreationError.swift
//  SAiOS-FlickrViewerLiveCoding
//
//  Created by Key Hoffman on 1/2/17.
//  Copyright © 2017 Key Hoffman. All rights reserved.
//

import Foundation

// MARK: - CreationError

enum CreationError {
    
    enum Flickr: Error, CustomStringConvertible {
        case metadata
        case comment
        case photo(forURL: String)
    }
}

// MARK: - CustomStringConvertible Conformance

extension CreationError.Flickr {
    var description: String {
        switch self {
        case .metadata: return "Unable to retrieve photos!"
        case .comment:  return "Unable to load comments!"
        case .photo:    return "Unable to download photo"
        }
    }
}
