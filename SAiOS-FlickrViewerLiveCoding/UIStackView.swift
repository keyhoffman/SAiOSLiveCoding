//
//  UIStackView.swift
//  SAiOS-FlickrViewerLiveCoding
//
//  Created by Key Hoffman on 1/2/17.
//  Copyright © 2017 Key Hoffman. All rights reserved.
//

import UIKit

// MARK: - UIStackView Extension

public extension UIStackView {
    /// Adds an array of views to the end of the arrangedSubviews Array
    ///
    /// - parameter views: an array of UIView to be added
    public func addArrangedSubviews(_ views: [UIView]) {
        views <^> addArrangedSubview
    }
    
    public func addArrangedSubviews(_ views: [UIView?]) {
        _ = views.flatMap { $0 } <^> addArrangedSubview
    }
}
