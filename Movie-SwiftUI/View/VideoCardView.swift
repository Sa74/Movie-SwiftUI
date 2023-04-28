//
//  VideoCardView.swift
//  Movie-SwiftUI
//
//  Created by Sasi Moorthy on 27.04.23.
//

import SwiftUI
import WebKit

struct VideoCardView: View {

    private let videoId: String
    private let videoUrl: URL
    private let thumbnailUrl: URL
    private let title: String
    private let subtitle: String

    @State var webViewWrapper: WebViewWrapper?

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
                if let webViewWrapper = webViewWrapper {
                    webViewWrapper
                        .cornerRadius(10)
                        .clipped()
                        .frame(
                            height: 200
                        )
                }

                AsyncImage(
                    url: thumbnailUrl,
                    content: { image in
                        image.resizable()
                    },
                    placeholder: {
                        ProgressView()
                    }
                )
                .cornerRadius(10)
                .clipped()
                .frame(
                    height: 200
                )

                Image(systemName: "play.fill")
                    .resizable()
                    .foregroundColor(.white)
                    .shadow(radius: 20)
                    .frame(
                        width: 50,
                        height: 50
                    )
            }
            .onTapGesture {
                guard webViewWrapper == nil else {
                    webViewWrapper?.playVideo()
                    return
                }
                webViewWrapper = WebViewWrapper(
                    videoUrl: videoUrl
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
