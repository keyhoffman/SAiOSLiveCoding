//
//  Optional.swift
//  SAiOS-FlickrViewerLiveCoding
//
//  Created by Key Hoffman on 1/2/17.
//  Copyright © 2017 Key Hoffman. All rights reserved.
//

import Foundation

// MARK: - Optional Extension

public extension Optional {
    public func toResult() -> Result<Wrapped> {
        guard let x = self else { return Result.init <| OptionalError.nonExistantValue(ofType: self) }
        return Result(x)
    }
    
    public func toResult(withError error: Error) -> Result<Wrapped> {
        guard let x = self else { return Result(error) }
        return Result(x)
    }
}

// MARK: - Optional Extension

public extension Optional {
    func apply<T>(_ f: ((Wrapped) -> T)?) -> T? {
        return f >>- { self <^> $0 }
    }
}
