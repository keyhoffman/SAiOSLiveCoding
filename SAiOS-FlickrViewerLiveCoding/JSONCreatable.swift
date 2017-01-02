//
//  JSONCreatable.swift
//  SAiOS-FlickrViewerLiveCoding
//
//  Created by Key Hoffman on 1/2/17.
//  Copyright © 2017 Key Hoffman. All rights reserved.
//

import Foundation

// MARK: - JSONCreatable Protocol

protocol JSONCreatable: Equatable {
    static func create(from dictionary: JSONDictionary) -> Result<Self>
}

// MARK: - JSONCreatable Extension

extension JSONCreatable {
    static func JSONObject<A>  (from object: Any) -> A?                { return object as? A }
    static func JSONString     (from object: Any) -> String?           { return object as? String }
    static func _JSONDictionary(from object: Any) -> JSONDictionary?   { return object as? JSONDictionary } // TODO: Find a better name for this function
    static func JSONArray      (from object: Any) -> [JSONDictionary]? { return object as? [JSONDictionary] }
}
