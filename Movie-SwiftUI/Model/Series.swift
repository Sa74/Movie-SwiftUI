//
//  Series.swift
//  Movie-SwiftUI
//
//  Created by Sasi Moorthy on 15.04.23.
//

import Combine
import Foundation

struct Series: Codable & Identifiable {
    let id: Int
    let name: String
    let overview: String
    let posterPath: String?
    let backdropPath: String?
    let firstAirDate: String
    let rating: Float?
    let voteCount: Int
    let isAdult: Bool

    var posterUrl: URL? {
        guard let posterPath = posterPath else {
            return nil
        }
        return Endpoint.imageUrl(for: posterPath, with: .w500)
    }

    var title: String {
        return name
    }

    var subtitle: String {
        return firstAirDate
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case overview = "overview"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case firstAirDate = "first_air_date"
        case rating = "vote_average"
        case voteCount = "vote_count"
        case isAdult = "adult"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        overview = try values.decode(String.self, forKey: .overview)
        posterPath = try values.decode(String?.self, forKey: .posterPath)
        backdropPath = try values.decode(String?.self, forKey: .backdropPath)
        firstAirDate = try values.decode(String.self, forKey: .firstAirDate)
        rating = try values.decode(Float.self, forKey: .rating)
        voteCount = try values.decode(Int.self, forKey: .voteCount)
        isAdult = try values.decode(Bool.self, forKey: .isAdult)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(overview, forKey: .overview)
        try container.encode(posterPath, forKey: .posterPath)
        try container.encode(backdropPath, forKey: .backdropPath)
        try container.encode(firstAirDate, forKey: .firstAirDate)
        try container.encode(rating, forKey: .rating)
        try container.encode(voteCount, forKey: .voteCount)
        try container.encode(isAdult, forKey: .isAdult)
    }
}
