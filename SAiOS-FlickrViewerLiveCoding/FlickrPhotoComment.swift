//
//  FlickrPhotoComment.swift
//  SAiOS-FlickrViewerLiveCoding
//
//  Created by Key Hoffman on 1/2/17.
//  Copyright © 2017 Key Hoffman. All rights reserved.
//

import Foundation

// MARK: - FlickrPhotoComment

struct FlickrPhotoComment: FlickrElement {
    let id:        String
    let ownerName: String
    let ownerID:   String
    let content:   String
}

// MARK: - FlickrAPIGetable Conformance

extension FlickrPhotoComment {
    static func create(from dict: JSONDictionary) -> Result<FlickrPhotoComment> {
        guard let id        = dict[FlickrConstants.Response.Keys.Comment.id]        >>- JSONString,
              let ownerName = dict[FlickrConstants.Response.Keys.Comment.ownerName] >>- JSONString,
              let ownerID   = dict[FlickrConstants.Response.Keys.Comment.ownerID]   >>- JSONString,
              let content   = dict[FlickrConstants.Response.Keys.Comment.content]   >>- JSONString else { return Result(CreationError.Flickr.comment) }
        return Result.init <| FlickrPhotoComment(id: id, ownerName: ownerName, ownerID: ownerID, content: content)
    }
}
