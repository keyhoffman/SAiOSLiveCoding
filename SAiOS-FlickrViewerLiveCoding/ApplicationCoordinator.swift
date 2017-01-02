//
//  ApplicationCoordinator.swift
//  SAiOS-FlickrViewerLiveCoding
//
//  Created by Key Hoffman on 1/2/17.
//  Copyright © 2017 Key Hoffman. All rights reserved.
//

import UIKit

// MARK: - ApplicationCoordinator

final class ApplicationCoordinator: Coordinator {
    
    // MARK: - Property Declarations
    
    private let window: UIWindow
    
    // MARK: - Initialization
    
    init(window: UIWindow) {
        self.window = window
    }
    
    // MARK: - Coordinator Conformance
    
    func start() {
        let flickrCoordinator = FlickrCoordinator(window: window)
        flickrCoordinator.start()
    }
}
