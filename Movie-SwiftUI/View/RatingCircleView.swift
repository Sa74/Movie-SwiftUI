//
//  RatingCircleView.swift
//  Movie-SwiftUI
//
//  Created by Sasi Moorthy on 16.04.23.
//

import SwiftUI

struct RatingCircleView: View {

    let rating: Float

    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 4.0)
                .opacity(0.6)
                .foregroundColor(
                    Color.yellow
                )
                .background(
                    Circle()
                        .fill(Color.black)
                )

            Circle()
                .trim(
                    from: 0.0,
                    to: CGFloat(rating / 10)
                )
                .stroke(
                    style: StrokeStyle(
                        lineWidth: 4.0,
                        lineCap: .round,
                        lineJoin: .round
                    )
                )
                .foregroundColor(
                    Color.yellow
                )
                .rotationEffect(
                    Angle(degrees: 270.0)
                )
                .background(
                    Circle()
                        .fill(Color.black)
                )

            Text(String(format: "%.1f", rating))
                .foregroundColor(.white)
                .font(.caption)
                .bold()
        }
    }
}

struct RatingCircleView_Previews: PreviewProvider {
    static var previews: some View {
        HStack(spacing: 10) {
            RatingCircleView(
                rating: 8.75
            )
            .frame(
                width: 60,
                height: 60
            )
            RatingCircleView(
                rating: 6.75
            )
            .frame(
                width: 60,
                height: 60
            )
            RatingCircleView(
                rating: 9.25
            )
            .frame(
                width: 60,
                height: 60
            )
            RatingCircleView(
                rating: 7
            )
            .frame(
                width: 60,
                height: 60
            )
        }
    }
}
