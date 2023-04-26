//
//  Movie.swift
//  Movie-SwiftUI
//
//  Created by Sasi Moorthy on 15.04.23.
//

import Combine
import Foundation

struct Movie: Codable & Identifiable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let backdropPath: String?
    let releaseDate: String
    let rating: Float?
    let voteCount: Int
    let isAdult: Bool

    var posterUrl: URL? {
        guard let posterPath = posterPath else {
            return nil
        }
        return Endpoint.imageUrl(for: posterPath, with: .w500)
    }

    var subtitle: String {
        return releaseDate
    }

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case overview = "overview"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case rating = "vote_average"
        case voteCount = "vote_count"
        case isAdult = "adult"
    }

    init(id: Int,
         title: String,
         overview: String,
         posterPath: String?,
         backdropPath: String?,
         releaseDate: String,
         rating: Float?,
         voteCount: Int,
         isAdult: Bool) {
        self.id = id
        self.title = title
        self.overview = overview
        self.posterPath = posterPath
        self.backdropPath = backdropPath
        self.releaseDate = releaseDate
        self.rating = rating
        self.voteCount = voteCount
        self.isAdult = isAdult
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        id = try values.decode(Int.self, forKey: .id)
        title = try values.decode(String.self, forKey: .title)
        overview = try values.decode(String.self, forKey: .overview)
        posterPath = try values.decode(String?.self, forKey: .posterPath)
        backdropPath = try values.decode(String?.self, forKey: .backdropPath)
        releaseDate = try values.decode(String.self, forKey: .releaseDate)
        rating = try values.decode(Float.self, forKey: .rating)
        voteCount = try values.decode(Int.self, forKey: .voteCount)
        isAdult = try values.decode(Bool.self, forKey: .isAdult)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(overview, forKey: .overview)
        try container.encode(posterPath, forKey: .posterPath)
        try container.encode(backdropPath, forKey: .backdropPath)
        try container.encode(releaseDate, forKey: .releaseDate)
        try container.encode(rating, forKey: .rating)
        try container.encode(voteCount, forKey: .voteCount)
        try container.encode(isAdult, forKey: .isAdult)
    }
}
