//
//  MediaListView.swift
//  Movie-SwiftUI
//
//  Created by Sasi Moorthy on 25.04.23.
//

import SwiftUI

struct MediaListView: View {

    enum Action {
        case didSelectMedia(Media)
        case didSelectFilter(String)
    }

    private let mediaList: MediaGroup
    private let title: String
    private let filters: [String]
    private let didPerformAction: ((Action) -> Void)?

    @State private var selectedSegmentIndex = 0

    init(
        mediaList: MediaGroup,
        title: String,
        filters: [String] = [],
        didPerformAction: ((Action) -> Void)?
    ) {
        self.mediaList = mediaList
        self.title = title
        self.filters = filters
        self.didPerformAction = didPerformAction
    }

    var body: some View {
        ZStack(alignment: .top) {
            List {
                Section {
                    ForEach(mediaList.results) { media in
                        NavigationLink {

                        } label: {
                            HStack(spacing: 10) {
                                PosterView(
                                    posterUrl: media.posterUrl ?? Image.placeholderUrl,
                                    rating: nil
                                )
                                .frame(
                                    width: 60,
                                    height: 80
                                )
                                VStack(spacing: 10) {
                                    Text(media.title)
                                        .bold()
                                        .frame(
                                            maxWidth: .infinity,
                                            alignment: .leading
                                        )
                                    Text(media.subtitle)
                                        .font(.footnote)
                                        .frame(
                                            maxWidth: .infinity,
                                            alignment: .leading
                                        )
                                }
                                if let rating = media.rating {
                                    RatingCircleView(rating: rating)
                                        .frame(
                                            width: 30,
                                            height: 30
                                        )
                                        .padding(.trailing, 10)
                                }
                            }
                        }
                    }
                } header: {
                    Picker(
                        selection: $selectedSegmentIndex,
                        label: Text("")
                    ) {
                        ForEach(
                            0..<filters.count,
                            id: \.self
                        ) { index in
                            Text(filters[index])
                                .tag(index)
                        }
                    }
                    .pickerStyle(.segmented)
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, 10)
                    .onChange(
                        of: selectedSegmentIndex,
                        perform: { newValue in

                        }
                    )
                }
            }
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
