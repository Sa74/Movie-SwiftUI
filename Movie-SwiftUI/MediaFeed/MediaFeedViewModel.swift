//
//  MediaFeedViewModel.swift
//  Movie-SwiftUI
//
//  Created by Sasi Moorthy on 16.04.23.
//

import Foundation

final class MediaFeedViewModel: ObservableObject {

    private let mediaFetcher: MediaFetcher
    private let htmlVideoFetcher: HTMLVideoFetcher

    @MainActor @Published var trendingMedia: [Endpoint.MediaType: MediaGroup] = [:]
    @MainActor @Published  var trailers: [Video]?
    @MainActor @Published var searchResult: MediaGroup?

    @MainActor
    var trendingMovies: MediaGroup? {
        return trendingMedia[.movie]
    }

    @MainActor
    var trendingTvShows: MediaGroup? {
        return trendingMedia[.series]
    }

    @MainActor
    var trendingPersons: MediaGroup? {
        return trendingMedia[.person]
    }

    @MainActor
    var latestTrailers: [Video]? {
        return trailers
    }

    init(
        mediaFetcher: MediaFetcher,
        htmlVideoFetcher: HTMLVideoFetcher
    ) {
        self.mediaFetcher = mediaFetcher
        self.htmlVideoFetcher = htmlVideoFetcher
    }

    @MainActor
    func fetchTrendingMedia(
        for type: Endpoint.MediaType,
        period: Endpoint.Period = .week
    ) {
        Task {
            do {
                guard trendingMedia[type] == nil else {
                    return
                }
                trendingMedia[type] = try await mediaFetcher.fetchTrendingMedias(
                    for: type,
                    within: period
                )
            } catch {
                print(error)
            }
        }
    }

    @MainActor
    func searchMedia(
        for title: String
    ) {
        Task {
            do {
                guard title.count > 1 else {
                    return
                }
                searchResult = try await mediaFetcher.searchMedias(
                    with: title,
                    for: .all
                )
            } catch {
                print(error)
            }
        }
    }

    @MainActor
    func fetchLatestTrailers(
        for type: Endpoint.TrailerType = .streaming
    ) {
        Task {
            do {
                guard trailers == nil else {
                    return
                }

                trailers = try await HTMLVideoFetcher()
                    .fetchVideos(
                        from: Endpoint.trailersUrl(for: type)
                    )
            } catch {
                print(error)
            }
        }
    }
}
