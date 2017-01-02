//
//  FlickrCollection.swift
//  SAiOS-FlickrViewerLiveCoding
//
//  Created by Key Hoffman on 1/2/17.
//  Copyright © 2017 Key Hoffman. All rights reserved.
//

import Foundation

// MARK: - FlickrCollection Protocol

protocol FlickrCollection: FlickrAPIGetable, Collection, ExpressibleByEmptySelf {
    associatedtype Element: FlickrElement
    var elements: Set<Element> { get }
    init(from array: [Element])
}

// MARK: - Collection Conformance

extension FlickrCollection {
    typealias FlickrIndex = SetIndex<Element>
    
    var startIndex: FlickrIndex { return elements.startIndex }
    var endIndex:   FlickrIndex { return elements.endIndex }
    
    subscript(i: FlickrIndex) -> Element {
        return elements[i]
    }
    
    func index(after i: FlickrIndex) -> FlickrIndex {
        return elements.index(after: i)
    }
}

// MARK: - Equatable Conformance

func == <T>(_ lhs: T, _ rhs: T) -> Bool where T: FlickrCollection {
    return lhs.elements == rhs.elements
}
