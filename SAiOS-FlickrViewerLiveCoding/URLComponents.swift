//
//  URLComponents.swift
//  SAiOS-FlickrViewerLiveCoding
//
//  Created by Key Hoffman on 1/2/17.
//  Copyright © 2017 Key Hoffman. All rights reserved.
//

import Foundation

// MARK: - URLComponents Extension

public extension URLComponents {
    init?(path: String?, scheme: String?, host: String?, queryItems: [URLQueryItem]) {
        self.init()
        guard let path = path else { return nil }
        self.path       = path
        self.scheme     = scheme
        self.host       = host
        self.queryItems = queryItems
    }
}
