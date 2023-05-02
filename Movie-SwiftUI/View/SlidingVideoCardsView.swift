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


struct SlidingVideoCardsView_Previews: PreviewProvider {
    static var previews: some View {
        SlidingVideoCardsView(
            title: "LATEST TRAILERS",
            videoList: [
                Video(
                    id: "71912",
                    media: "tv",
                    dataId: "EUlC8ue8NFI",
                    title: "The Witcher",
                    subtitle: "Season 3: Official Trailer",
                    thumbnailPath: "/t/p/w355_and_h200_multi_faces/jBJWaqoSCiARWtfV0GlqHrcdidd.jpg"
                ),
                Video(
                    id: "82856",
                    media: "tv",
                    dataId: "9-HW5K6WZg8",
                    title: "The Mandalorian",
                    subtitle: "All Episodes Now Streaming",
                    thumbnailPath: "/t/p/w355_and_h200_multi_faces/6Lw54zxm6BAEKJeGlabyzzR5Juu.jpg"
                )]
        )
    }
}
