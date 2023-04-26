//
//  PosterView.swift
//  Movie-SwiftUI
//
//  Created by Sasi Moorthy on 16.04.23.
//

import SwiftUI

struct PosterView: View {

    let posterUrl: URL
    let rating: Float?

    var body: some View {
        ZStack {
            AsyncImage(
                url: posterUrl,
                content: { image in
                    image.resizable()
                },
                placeholder: {
                    ProgressView()
                }
            )
            .cornerRadius(10)
            .clipped()

            if let rating = rating {
                HStack {
                    VStack(alignment: .leading) {
                        Spacer()
                        RatingCircleView(
                            rating: rating
                        )
                        .frame(
                            width: 35,
                            height: 35,
                            alignment: .center
                        )
                    }
                    .padding(.all, 5)

                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .padding(.all, 0)
            }
        }
    }
}

struct PosterView_Previews: PreviewProvider {
    static var previews: some View {
        PosterView(
            posterUrl: Endpoint.imageUrl(
                for: "/wXqWR7dHncNRbxoEGybEy7QTe9h.jpg",
                with: .w500
            ),
            rating: 9.5
        )
        .frame(
            width: 180,
            height: 280
        )
    }
}
