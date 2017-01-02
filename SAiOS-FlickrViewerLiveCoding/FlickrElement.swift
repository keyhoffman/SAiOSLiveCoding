//
//  FlickrElement.swift
//  SAiOS-FlickrViewerLiveCoding
//
//  Created by Key Hoffman on 1/2/17.
//  Copyright © 2017 Key Hoffman. All rights reserved.
//

import Foundation

// MARK: - FlickrElement Protocol

protocol FlickrElement: JSONCreatable, Hashable {
    var id:      String { get }
    var ownerID: String { get }
}

// MARK: - Hashable Conformance

extension FlickrElement {
    var hashValue: Int { return id.hashValue ^ ownerID.hashValue }
}

// MARK: - Equatable Conformance

func == <T>(_ lhs: T, _ rhs: T) -> Bool where T: FlickrElement {
    return lhs.hashValue == rhs.hashValue
}
