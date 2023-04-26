//
//  Endpoint.swift
//  Movie-SwiftUI
//
//  Created by Sasi Moorthy on 15.04.23.
//

import Foundation

struct Endpoint {
    var path: String
    var queryItems = [URLQueryItem]()
}

extension Endpoint {
    enum MediaType: String {
        case all = "multi"
        case movie
        case series = "tv"
        case person
    }

    enum Period: String {
        case day
        case week
    }
}

extension Endpoint {

    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        components.path = "/3/" + path
        components.queryItems = [authenticationQueryItem] + queryItems

        guard let url = components.url else {
            preconditionFailure(
                "Invalid URL components: \(components)"
            )
        }
        return url
    }

    private var authenticationQueryItem: URLQueryItem {
        return URLQueryItem(
            name: "api_key",
            value: "2696829a81b1b5827d515ff121700838"
        )
    }
}

extension Endpoint {

    enum ImageSize: String {
        case w92 = "w92"
        case w185 = "w185"
        case w500 = "w500"
    }

    static func imageUrl(for path: String, with size: ImageSize) -> URL {
        var components = URLComponents()
        components.scheme = "http"
        components.host = "image.tmdb.org"
        components.path = "/t/p/" + size.rawValue + path

        guard let url = components.url else {
            preconditionFailure(
                "Invalid URL components: \(components)"
            )
        }
        return url
    }
}
