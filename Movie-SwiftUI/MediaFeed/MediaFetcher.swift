//
//  MediaFetcher.swift
//  Movie-SwiftUI
//
//  Created by Sasi Moorthy on 16.04.23.
//

import Combine
import Foundation

final class MediaFetcher {

    private let networkHandler: NetworkProtocol

    init(networkHandler: NetworkProtocol = NetworkHandler()) {
        self.networkHandler = networkHandler
    }

    func fetchTrendingMedias(
        for type: Endpoint.MediaType,
        within period: Endpoint.Period
    ) async throws -> MediaList? {
        return try await networkHandler.fetchData(
            from: Endpoint.trendingMedia(
                for: type,
                within: period
            ).url
        )
    }

    func searchMedias(
        with title: String,
        for type: Endpoint.MediaType
    ) async throws -> MediaList? {
        return try await networkHandler.fetchData(
            from: Endpoint.searchMedia(
                with: title,
                for: type
            ).url
        )
    }

    func fetchMediaDetails(
        for id: Int
    ) async throws -> Media? {
        return try await networkHandler.fetchData(
            from: Endpoint.fetchMediaDetails(
                for: id
            ).url
        )
    }
}

extension Endpoint {
    static func trendingMedia(
        for type: MediaType,
        within period: Period
    ) -> Self {
        return Endpoint(
            path: "trending/\(type.rawValue)/\(period.rawValue)"
        )
    }

    static func searchMedia(
        with title: String,
        for type: MediaType,
        at page: Int = 1
    ) -> Self {
        return Endpoint(
            path: "search/\(type.rawValue)",
            queryItems: [
                URLQueryItem(name: "query", value: title),
                URLQueryItem(name: "language", value: "en-US"),
                URLQueryItem(name: "page", value: String(page)),
                URLQueryItem(name: "include_adult", value: "false")
            ]
        )
    }

    static func fetchMediaDetails(
        for id: Int
    ) -> Self {
        return Endpoint(
            path: "",
            queryItems: []
        )
    }
}
