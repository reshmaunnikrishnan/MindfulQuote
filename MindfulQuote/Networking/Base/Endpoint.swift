//
//  Endpoint.swift
//  TopStories
//
//  Created by Reshma Unnikrishnan on 20.09.22.
//

import Foundation

struct Endpoint {
    let path: String
    let queryItems: [URLQueryItem]?
}

extension Endpoint {
    static func fetchQuote(with lang : String) -> Endpoint {
        return Endpoint(path: "/v2/mindful",
                        queryItems: [
                            URLQueryItem(name: "lang", value: lang),
                            URLQueryItem(name: "uid", value: "abc")
                        ])
    }
}

extension Endpoint {
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "servicegateway.7mind.de"
        components.path = path
        components.queryItems = queryItems
        return components.url
    }
}

