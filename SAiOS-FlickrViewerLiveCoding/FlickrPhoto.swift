//
//  FlickrPhoto.swift
//  SAiOS-FlickrViewerLiveCoding
//
//  Created by Key Hoffman on 1/2/17.
//  Copyright © 2017 Key Hoffman. All rights reserved.
//

import UIKit

// MARK: - FlickrPhoto

struct FlickrPhoto: Equatable {
    let photo:    UIImage
    let metadata: FlickrPhotoMetadata
}

// MARK: - Equatable Conformance

func == (_ lhs: FlickrPhoto, _ rhs: FlickrPhoto) -> Bool {
    return lhs.metadata == rhs.metadata
}

