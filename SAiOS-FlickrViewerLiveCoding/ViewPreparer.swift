//
//  ViewPreparer.swift
//  SAiOS-FlickrViewerLiveCoding
//
//  Created by Key Hoffman on 1/2/17.
//  Copyright © 2017 Key Hoffman. All rights reserved.
//

import Foundation

// MARK: - ViewPreparer

protocol ViewPreparer {
    associatedtype PreparedType: Preparable
    static func prepare(_ subject: PreparedType)
}
