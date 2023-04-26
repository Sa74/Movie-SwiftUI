//
//  MediaFeedViewModel.swift
//  Movie-SwiftUI
//
//  Created by Sasi Moorthy on 16.04.23.
//

import Foundation

final class MediaFeedViewModel: ObservableObject {

    private let mediaFetcher: MediaFetcher

    @MainActor @Published var trendingMedia: [Endpoint.MediaType: MediaList] = [:]
    @MainActor @Published var searchResult: MediaList?

    @MainActor
    var trendingMovies: MediaList? {
        return trendingMedia[.movie]
    }

    @MainActor
    var trendingTvShows: MediaList? {
        return trendingMedia[.series]
    }

    @MainActor
    var trendingPersons: MediaList? {
        return trendingMedia[.person]
    }

    init(mediaFetcher: MediaFetcher) {
        self.mediaFetcher = mediaFetcher
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
}
