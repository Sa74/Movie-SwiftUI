//
//  SlidingMediaCardsView.swift
//  Movie-SwiftUI
//
//  Created by Sasi Moorthy on 16.04.23.
//

import SwiftUI

struct SlidingMediaCardsView: View {

    private let title: String
    private let mediaGroup: MediaGroup?
    private let mediaDetailViewCreation: ((Media) -> AnyView)?

    init(
        title: String,
        mediaGroup: MediaGroup?,
        mediaDetailViewCreation: ((Media) -> AnyView)? = nil
    ) {
        self.title = title
        self.mediaGroup = mediaGroup
        self.mediaDetailViewCreation = mediaDetailViewCreation
    }

    var body: some View {
        VStack(spacing: 15) {
            HStack(spacing: 10) {
                Text(title)
                    .font(.callout)
                    .bold()
                    .padding(.horizontal, 20)
                    .frame(
                        maxWidth: .infinity,
                        alignment: .leading
                    )

                NavigationLink {
                    if let mediaList = mediaGroup {
                        MediaListView(
                            mediaList: mediaList,
                            title: title,
                            didPerformAction: nil
                        )
                    }
                } label: {
                    Image(systemName: "arrow.forward")
                        .padding(.trailing, 20)
                        .foregroundColor(.black)
                }
            }

            if let trendingMedias = mediaGroup {
                ScrollView(.horizontal) {
                    LazyHStack(
                        alignment: .top,
                        spacing: 15
                    ) {
                        ForEach(trendingMedias.results) { media in
                            NavigationLink {
                                mediaDetailViewCreation?(media)
                            } label: {
                                MediaCardView(
                                    posterUrl: media.posterUrl,
                                    rating: media.rating,
                                    title: media.title,
                                    subtitle: media.subtitle
                                )
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                }
            }
        }
        .padding(.all, 0)
        .frame(height: 360)
    }
}

struct SlidingMediaCardsView_Previews: PreviewProvider {
    static var previews: some View {
        SlidingMediaCardsView(
            title: "TRENDING MOVIES",
            mediaGroup: MediaGroup(
                page: 1,
                results: [.movie(Movie(id: 1,
                                       title: "John Wick",
                                       overview: "",
                                       posterPath: "/wXqWR7dHncNRbxoEGybEy7QTe9h.jpg",
                                       backdropPath: "",
                                       releaseDate: "2014-10-22",
                                       rating: 9,
                                       voteCount: 10,
                                       isAdult: false)),
                          .movie(Movie(id: 2,
                                       title: "John Wick: Chapter 2",
                                       overview: "",
                                       posterPath: "/huR3i1oxVkipuAJVF2UVVxV9alC.jpg",
                                       backdropPath: "",
                                       releaseDate: "2017-02-08",
                                       rating: 9.2,
                                       voteCount: 10,
                                       isAdult: false)),
                          .movie(Movie(id: 3,
                                       title: "John Wick: Chapter 3 - Parabellum",
                                       overview: "",
                                       posterPath: "/ziEuG1essDuWuC5lpWUaw1uXY2O.jpg",
                                       backdropPath: "",
                                       releaseDate: "2019-05-15",
                                       rating: 9.5,
                                       voteCount: 10,
                                       isAdult: false)),
                          .movie(Movie(id: 4,
                                       title: "John Wick: Chapter 4",
                                       overview: "",
                                       posterPath: "/vZloFAK7NmvMGKE7VkF5UHaz0I.jpg",
                                       backdropPath: "",
                                       releaseDate: "2023-03-22",
                                       rating: 9.7,
                                       voteCount: 10,
                                       isAdult: false))],
                totalPages: 1,
                totalResults: 100
            )
        )
    }
}
