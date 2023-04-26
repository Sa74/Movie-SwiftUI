//
//  ContentView.swift
//  Movie-SwiftUI
//
//  Created by Sasi Moorthy on 11.04.23.
//

import Combine
import SwiftUI

struct MediaFeedView: View {

    @ObservedObject private var viewModel: MediaFeedViewModel
    @ObservedObject private var searchFieldHandler: SearchFieldHandler

    init(viewModel: MediaFeedViewModel) {
        self.viewModel = viewModel
        self.searchFieldHandler = SearchFieldHandler { searchText in
            if searchText.count == 0 {
                viewModel.searchResult = nil
            }
            viewModel.searchMedia(for: searchText)
        }
    }

    var body: some View {
        NavigationStack {
            VStack {
                if let searchResult = viewModel.searchResult {
                    MediaListView(
                        mediaList: searchResult,
                        title: "TOP RESULTS",
                        didPerformAction: nil
                    )
                } else {
                    feedView
                }
            }
            .navigationTitle("The Movie DB")
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .topLeading
            )
            .padding(.all, 0)
        }
        .accentColor(.black)
        .searchable(
            text: $searchFieldHandler.searchText,
            prompt: "Search for a movie, tv show, person"
        )
    }

    private var feedView: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 10) {
                SlidingMediaCardsView(
                    title: "TRENDING MOVIES",
                    trendingMedias: viewModel.trendingMovies
                )
                .onAppear {
                    viewModel.fetchTrendingMedia(for: .movie)
                }

                SlidingMediaCardsView(
                    title: "TRENDING TV SHOWS",
                    trendingMedias: viewModel.trendingTvShows
                )
                .onAppear {
                    viewModel.fetchTrendingMedia(for: .series)
                }

                SlidingMediaCardsView(
                    title: "POPULAR PERSONS",
                    trendingMedias: viewModel.trendingPersons
                )
                .onAppear {
                    viewModel.fetchTrendingMedia(for: .person)
                }
            }
        }
    }
}

struct MediaFeedView_Previews: PreviewProvider {
    static var previews: some View {
        MediaFeedView(
            viewModel: MediaFeedViewModel(
                mediaFetcher: MediaFetcher()
            )
        )
    }
}
