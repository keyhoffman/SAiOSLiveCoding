//
//  Sequence.swift
//  SAiOS-FlickrViewerLiveCoding
//
//  Created by Key Hoffman on 1/2/17.
//  Copyright © 2017 Key Hoffman. All rights reserved.
//

import UIKit

// MARK: - Sequence Extension

public extension Sequence {
    func apply<T>(_ fs: [(Iterator.Element) -> T]) -> [T] {
        return fs >>- { self.map($0) }
    }
}

// MARK: - Sequence Extension

// FIXME: Find a way to make this generic!!!!! Possibly with type erasure
extension Sequence where Iterator.Element == Result<FlickrPhotoMetadata> {
    
    /// Transforms an `Array` of `Result` of `FlickrImageMetadata` into
    /// a `Result` of an `Array` of `FlickrImageMetadata`.
    ///
    /// - note: Transformation Structure ====>>  [Result\<FlickrPhotoMetadata\>] -> Result<[FlickrPhotoMetadata]>
    ///
    /// - returns: A `Result` of an `Array` of `FlickrImageMetadata`
    var inverted: Result<[FlickrPhotoMetadata]> {
        return Result.init <| self.flatMap { $0.toOptional }
    }
}

// MARK: - Sequence Extension

// FIXME: Find a way to make this generic!!!!! Possibly with type erasure
extension Sequence where Iterator.Element == Result<UIImage> {
    var inverted: Result<[UIImage]> {
        return Result.init <| self.flatMap { $0.toOptional }
    }
}

// MARK: - Sequence Extension

// FIXME: Find a way to make this generic!!!!! Possibly with type erasure
extension Sequence where Iterator.Element == Result<FlickrPhotoComment> {
    var inverted: Result<[FlickrPhotoComment]> {
        return Result.init <| self.flatMap { $0.toOptional }
    }
}
