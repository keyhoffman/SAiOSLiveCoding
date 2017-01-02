//
//  FlickrAPIGetable.swift
//  SAiOS-FlickrViewerLiveCoding
//
//  Created by Key Hoffman on 1/2/17.
//  Copyright © 2017 Key Hoffman. All rights reserved.
//

import Foundation

// MARK: - FlickrAPIGetable Protocol

protocol FlickrAPIGetable: RESTGetable {}

// MARK: - FlickrAPIGetable Extension

extension FlickrAPIGetable {
    static var urlGeneralQueryParameters: URLParameters {
        return [
            FlickrConstants.Parameters.Keys.General.apiKey:         FlickrConstants.Parameters.Values.General.apiKey,
            FlickrConstants.Parameters.Keys.General.responseFormat: FlickrConstants.Parameters.Values.General.responseFormat,
            FlickrConstants.Parameters.Keys.General.noJSONCallback: FlickrConstants.Parameters.Values.General.noJSONCallback
        ]
    }
    
    // MARK: - RESTGetable Conformance
    
    static var urlAddressParameters: URLParameters {
        return [
            host:   FlickrConstants.API.host,
            path:   FlickrConstants.API.path,
            scheme: FlickrConstants.API.scheme
        ]
    }
}
