//
//  Coordinator.swift
//  SAiOS-FlickrViewerLiveCoding
//
//  Created by Key Hoffman on 1/2/17.
//  Copyright © 2017 Key Hoffman. All rights reserved.
//

import Foundation

// MARK: - Coordinator Protocol

protocol Coordinator: class {
    func start()
}

// MARK: - SubCoordinator Protocol

protocol SubCoordinator: Coordinator {}
