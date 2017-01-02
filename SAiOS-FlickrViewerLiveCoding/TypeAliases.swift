//
//  TypeAliases.swift
//  SAiOS-FlickrViewerLiveCoding
//
//  Created by Key Hoffman on 1/2/17.
//  Copyright © 2017 Key Hoffman. All rights reserved.
//

import Foundation

// MARK: - URLParamters

public typealias URLParameters = [String: String]

// MARK: - JSONDictionary

public typealias JSONDictionary = [String: Any]

// MARK: - ResultBlock

public typealias ResultBlock<T> = (Result<T>) -> Void

// MARK: - Percentage

public typealias Percentage = Float

// MARK: - PreparedConfigurable

typealias PreparedConfigurable = Preparable & Configurable
