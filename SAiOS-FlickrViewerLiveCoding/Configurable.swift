//
//  Configurable.swift
//  SAiOS-FlickrViewerLiveCoding
//
//  Created by Key Hoffman on 1/2/17.
//  Copyright © 2017 Key Hoffman. All rights reserved.
//

import Foundation

// MARK: - Configurable Protocol

protocol Configurable {
    associatedtype DataType
    func configure(_ data: DataType)
}
