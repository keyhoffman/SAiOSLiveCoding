//
//  Percentage.swift
//  SAiOS-FlickrViewerLiveCoding
//
//  Created by Key Hoffman on 1/2/17.
//  Copyright © 2017 Key Hoffman. All rights reserved.
//

import UIKit

// MARK: - Percentage Extension

public extension Percentage {
    var cgFloat: CGFloat {
        return CGFloat(self)
    }
}

// MARK: - Percentage Extension

public extension Percentage {
    static var oneHundred: Percentage { return 1.00 }
    static var ninety:     Percentage { return 0.90 }
    static var seventy:    Percentage { return 0.70 }
    static var sixty:      Percentage { return 0.60 }
    static var fifty:      Percentage { return 0.50 }
    static var forty:      Percentage { return 0.40 }
    static var thirty:     Percentage { return 0.30 }
    static var twenty:     Percentage { return 0.20 }
    static var ten:        Percentage { return 0.10 }
    static var seven:      Percentage { return 0.07 }
    static var five:       Percentage { return 0.05 }
    static var four:       Percentage { return 0.04 }
    static var zero:       Percentage { return 0.00 }
}
