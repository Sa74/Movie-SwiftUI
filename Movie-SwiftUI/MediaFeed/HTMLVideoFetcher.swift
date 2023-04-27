//
//  HTMLVideoFetcher.swift
//  Movie-SwiftUI
//
//  Created by Sasi Moorthy on 27.04.23.
//

import Foundation

import SwiftSoup

struct HTMLVideoFetcher {

    func fetchVideos(
        from url: URL
    ) async throws -> [Video] {
        let htmlString = try String(
            contentsOf: url,
            encoding: .ascii
        )
        let parsedData = try SwiftSoup.parse(htmlString)
        let mediaElements = try! parsedData.select("a.image.play_trailer")

        var mediaIds: Set<Video> = []
        for element in mediaElements {
            guard let hrefValue = try? element.attr("href").components(separatedBy: "/"),
                  let mediaType = Endpoint.MediaType(rawValue: hrefValue[1]),
                  let id = hrefValue.last,
                  let dataId = try? element.attr("data-id"),
                  let title = try? element.attr("title"),
                  let subtitle = try? element.attr("data-title"),
                  let thumbnailPath = try? element.children().attr("src") else {
                continue
            }
            mediaIds.insert(
                Video(
                    id: id,
                    mediaType: mediaType,
                    dataId: dataId,
                    title: title,
                    subtitle: subtitle,
                    thumbnailPath: thumbnailPath
                )
            )
        }
        return Array(mediaIds)
    }
}

extension Endpoint {

    enum TrailerType: String {
        case streaming
        case onTv = "on_tv"
        case forRent = "for-rent"
        case inTheaters = "in-theaters"
    }

    static func trailersUrl(for type: TrailerType) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "www.themoviedb.org"
        components.path = "/remote/panel"
        components.queryItems = [
            URLQueryItem(name: "panel", value: "trailer_scroller"),
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "group", value: type.rawValue),
            URLQueryItem(name: "include_adult", value: "false")
        ]

        guard let url = components.url else {
            preconditionFailure(
                "Invalid URL components: \(components)"
            )
        }
        return url
    }

    static func youTubeVideoUrl(for id: String) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "www.youtube.com"
        components.path = "/embed/" + id

        guard let url = components.url else {
            preconditionFailure(
                "Invalid URL components: \(components)"
            )
        }
        return url
    }
}

