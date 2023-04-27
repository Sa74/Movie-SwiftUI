//
//  SlidingVideoCardView.swift
//  Movie-SwiftUI
//
//  Created by Sasi Moorthy on 27.04.23.
//

import SwiftUI

struct SlidingVideoCardsView: View {

    private let title: String
    private let videoList: [Video]?

    init(
        title: String,
        videoList: [Video]?
    ) {
        self.title = title
        self.videoList = videoList
    }

    var body: some View {
        VStack(spacing: 15) {
            Text(title)
                .font(.callout)
                .bold()
                .padding(.horizontal, 20)
                .frame(
                    maxWidth: .infinity,
                    alignment: .leading
                )

            ScrollView(.horizontal) {
                LazyHStack(
                    alignment: .top,
                    spacing: 15
                ) {
                    if let videoList = videoList {
                        ForEach(videoList) { video in
                            VideoCardView(
                                videoId: video.dataId,
                                youTubeUrl: video.videoUrl,
                                thumbnailUrl: video.thumbnailUrl,
                                title: video.title,
                                subtitle: video.subtitle
                            )
                        }
                    }
                }
                .padding(.horizontal, 20)
            }
        }
        .padding(.all, 0)
        .frame(height: 300)
    }
}
