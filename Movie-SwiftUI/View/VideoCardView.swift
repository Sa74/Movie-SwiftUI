//
//  VideoCardView.swift
//  Movie-SwiftUI
//
//  Created by Sasi Moorthy on 27.04.23.
//

import SwiftUI

struct VideoCardView: View {

    private let videoId: String
    private let videoUrl: URL
    private let thumbnailUrl: URL
    private let title: String
    private let subtitle: String

    init(
        videoId: String,
        youTubeUrl: URL,
        thumbnailUrl: URL,
        title: String,
        subtitle: String
    ) {
        self.videoId = videoId
        self.videoUrl = youTubeUrl
        self.thumbnailUrl = thumbnailUrl
        self.title = title
        self.subtitle = subtitle
    }

    var body: some View {
        VStack(spacing: 5) {
            ZStack {

                // STUPID HACK: To hide WebView from display and make the view look more native ;)
                // Idle solution would be to get videoUrl from server and use AVPlayer instead of YouTube videos
                WebView(webUrl: videoUrl)
                    .cornerRadius(10)
                    .clipped()
                    .frame(
                        height: 200
                    )

                AsyncImage(
                    url: thumbnailUrl,
                    content: { image in
                        image.resizable()
                    },
                    placeholder: {
                        ProgressView()
                    }
                )
                .allowsHitTesting(false)
                .cornerRadius(10)
                .clipped()
                .frame(
                    height: 200
                )

                Image(systemName: "play.fill")
                    .resizable()
                    .foregroundColor(.white)
                    .shadow(radius: 20)
                    .allowsHitTesting(false)
                    .frame(
                        width: 50,
                        height: 50
                    )
            }

            Text(title)
                .font(.callout)
                .bold()
                .lineLimit(3)
                .multilineTextAlignment(.center)
                .frame(
                    maxWidth: .infinity,
                    alignment: .leading
                )

            Text(subtitle)
                .font(.caption)
                .multilineTextAlignment(.center)
                .frame(
                    maxWidth: .infinity,
                    alignment: .leading
                )
            Spacer()
        }
        .frame(
            width: 300,
            height: 260
        )
    }
}
