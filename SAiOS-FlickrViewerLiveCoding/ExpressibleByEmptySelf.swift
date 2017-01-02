//
//  ExpressibleByEmptySelf.swift
//  SAiOS-FlickrViewerLiveCoding
//
//  Created by Key Hoffman on 1/2/17.
//  Copyright © 2017 Key Hoffman. All rights reserved.
//

import Foundation

// MARK: - ExpressibleByEmptySelf Protocol

protocol ExpressibleByEmptySelf {
    init()
}

// MARK: - ExpressibleByEmptySelf Extension

extension ExpressibleByEmptySelf {
    static var empty: Self {
        return Self()
    }
}

extension String:     ExpressibleByEmptySelf {}
extension Dictionary: ExpressibleByEmptySelf {}
extension Set:        ExpressibleByEmptySelf {}
