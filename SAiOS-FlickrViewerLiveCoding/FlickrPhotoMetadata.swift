//
//  FlickrPhotoMetadata.swift
//  SAiOS-FlickrViewerLiveCoding
//
//  Created by Key Hoffman on 1/2/17.
//  Copyright © 2017 Key Hoffman. All rights reserved.
//

import UIKit

// MARK: - FlickrPhotoMetadata

struct FlickrPhotoMetadata: FlickrElement {
    let id:      String
    let url:     String
    let title:   String
    let ownerID: String
    let ownerName: String
}

// MARK: - FlickrAPIGetable Conformance

extension FlickrPhotoMetadata {
    static func create(from dict: JSONDictionary) -> Result<FlickrPhotoMetadata> {
        guard let id      = dict[FlickrConstants.Response.Keys.Metadata.id]          >>- JSONString,
              let url     = dict[FlickrConstants.Response.Keys.Metadata.url]         >>- JSONString,
              let title   = dict[FlickrConstants.Response.Keys.Metadata.title]       >>- JSONString,
              let ownerId = dict[FlickrConstants.Response.Keys.Metadata.ownerID]     >>- JSONString,
              let ownerName = dict[FlickrConstants.Response.Keys.Metadata.ownerName] >>- JSONString else { return Result(CreationError.Flickr.metadata) }
        return Result.init <| FlickrPhotoMetadata(id: id, url: url, title: title, ownerID: ownerId, ownerName: ownerName)
    }
}

// MARK: - Module Instance API

extension FlickrPhotoMetadata {
    var commentParameter: URLParameters {
//        return [FlickrConstants.Parameters.Keys.PhotoCommentCollection.photoID: id]
        return [FlickrConstants.Parameters.Keys.CommentCollection.photoID: "29466047852"]
    }
    
    func getFlickrPhoto(withBlock block: @escaping ResultBlock<FlickrPhoto>) { // FIXME: HANDLE ERROR AND CLEAN THIS UP!!!!!!
        DispatchQueue.global(qos: .userInitiated).async {
            let data = URL(string: self.url).flatMap { try? Data(contentsOf:$0) }
            DispatchQueue.main.async {
                (data >>- UIImage.init).toResult <| CreationError.Flickr.photo(forURL: self.url) <^> { downloadedImage in (downloadedImage, self) |> (FlickrPhoto.init |>> Result.init |>> block) }
            }
        }
    }
}
