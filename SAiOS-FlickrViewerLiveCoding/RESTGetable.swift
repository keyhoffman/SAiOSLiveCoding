//
//  RESTGetable.swift
//  SAiOS-FlickrViewerLiveCoding
//
//  Created by Key Hoffman on 1/2/17.
//  Copyright © 2017 Key Hoffman. All rights reserved.
//

import Foundation

// MARK: - RESTGetable Protocol

protocol RESTGetable: JSONCreatable {
    static var urlQueryParameters:   URLParameters { get }
    static var urlAddressParameters: URLParameters { get }
}

// MARK: - Module Static `urlAddressParameters` Keys

extension RESTGetable {
    static var scheme: String { return "scheme" }
    static var host:   String { return "host" }
    static var path:   String { return "path" }
}

// MARK: - Module Static API

extension RESTGetable {
    static func get(queryParameters: URLParameters = .empty, withBlock block: @escaping ResultBlock<Self>) { // FIXME: HANDLE ERROR
        queryParameters |> (url >-> urlRequest) <^> { request in dataTask(for: request, with: block) }
    }
}

// MARK: - Fileprivate URL Configuration API

fileprivate extension RESTGetable {
    fileprivate static func urlRequest(for url: URL) -> Result<URLRequest> {
        print("UURRLL", url.absoluteURL)
        return Result.init <| URLRequest(url: url)
    }
    
    fileprivate static func url(queryParameters: URLParameters = .empty) -> Result<URL> {
        return Result.init <| ((URLComponents(path:       urlAddressParameters[path],
                                              scheme:     urlAddressParameters[scheme],
                                              host:       urlAddressParameters[host],
                                              queryItems: (urlQueryParameters + queryParameters).map(URLQueryItem.init)) >>- { components in components.url }),
                               RESTGetableError.invalidURL(parameters: urlQueryParameters))
    }
}

// MARK: - Fileprivate Static API

fileprivate extension RESTGetable {
    fileprivate static func dataTask(for request: URLRequest, with block: @escaping ResultBlock<Self>) {
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                (RESTGetableResponse(data: data, urlResponse: response), error) |> (Result.init >-> parse(response:) >-> decode(json:) >-> create >-> block)
            }
        }.resume()
    }
    
    private static func parse(response: RESTGetableResponse) -> Result<Data> {
        return RESTGetableResponse.successRange.contains(response.statusCode) ? Result(response.data) : Result.init <| RESTGetableError.invalidResponseStatus(code: response.statusCode)
    }
    
    private static func decode(json data: Data) -> Result<JSONDictionary> {
        do    { return (try JSONSerialization.jsonObject(with: data, options: .allowFragments) >>- _JSONDictionary).toResult <| RESTGetableError.couldNotParseJSON }
        catch { return Result(error) }
    }
}


// MARK: - RESTGetableResponse

fileprivate struct RESTGetableResponse: Equatable {
    let data:       Data
    let statusCode: Int
}

fileprivate extension RESTGetableResponse {
    init?(data: Data?, urlResponse: URLResponse?) {
        guard let data = data else { return nil }
        self.data  = data
        statusCode = (urlResponse as? HTTPURLResponse)?.statusCode ?? 500
    }
}

fileprivate extension RESTGetableResponse {
    static let successRange = 200..<300
}

// MARK: - Equatable Conformance

fileprivate func == (_ lhs: RESTGetableResponse, _ rhs: RESTGetableResponse) -> Bool {
    return lhs.statusCode == rhs.statusCode && lhs.data == rhs.data
}
