//
//  StandardLibOverloads.swift
//  SAiOS-FlickrViewerLiveCoding
//
//  Created by Key Hoffman on 1/2/17.
//  Copyright © 2017 Key Hoffman. All rights reserved.
//

import Foundation

// MARK: - Pure Dictionary Addition

public func + <A, B>(_ lhs: Dictionary<A, B>, _ rhs: Dictionary<A, B>) -> Dictionary<A, B> {
    guard let first = rhs.first else { return lhs }
    
    var newLeft  = lhs
    var newRight = rhs
    
    newLeft.updateValue(first.value, forKey: first.key)
    newRight[first.key] = nil
    
    return newLeft + newRight
}
