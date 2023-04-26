//
//  MediaCardView.swift
//  Movie-SwiftUI
//
//  Created by Sasi Moorthy on 16.04.23.
//

import SwiftUI

struct MediaCardView: View {

    private let posterUrl: URL?
    private let rating: Float?
    private let title: String
    private let subtitle: String

    init(
        posterUrl: URL?,
        rating: Float? = nil,
        title: String,
        subtitle: String
    ) {
        self.posterUrl = posterUrl
        self.rating = rating
        self.title = title
        self.subtitle = subtitle
    }

    var body: some View {
        VStack(spacing: 5) {
            HStack {
                if let posterUrl = posterUrl {
                    PosterView(
                        posterUrl: posterUrl,
                        rating: rating
                    )
                }
            }
            .frame(height: 240)
            Text(title)
                .font(.callout)
                .bold()
                .frame(
                    maxWidth: .infinity,
                    alignment: .leading
                )
                .lineLimit(3)
            Text(subtitle)
                .font(.caption)
                .frame(
                    maxWidth: .infinity,
                    alignment: .leading
                )
            Spacer()
        }
        .frame(
            width: 160,
            height: 340
        )
    }
}

struct MediaCardView_Previews: PreviewProvider {
    static var previews: some View {
        MediaCardView(
            posterUrl: Endpoint.imageUrl(
                for: "/wXqWR7dHncNRbxoEGybEy7QTe9h.jpg",
                with: .w500
            ),
            rating: 9.5,
            title: "John Wick",
            subtitle: "24 October, 2014"
        )
    }
}
