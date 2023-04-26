//
//  Media.swift
//  Movie-SwiftUI
//
//  Created by Sasi Moorthy on 19.04.23.
//

import Foundation

protocol MediaProtocol: Codable & Identifiable {
    var posterUrl: URL? { get }
    var rating: Float? { get }
    var title: String { get }
    var subtitle: String { get }
}

enum Media: MediaProtocol {
    case movie(Movie)
    case series(Series)
    case person(Person)

    var id: Int {
        switch self {
        case let .movie(movie):
            return movie.id
        case let .series(series):
            return series.id
        case let .person(person):
            return person.id
        }
    }

    var posterUrl: URL? {
        switch self {
        case let .movie(movie):
            return movie.posterUrl
        case let .series(series):
            return series.posterUrl
        case let .person(person):
            return person.posterUrl
        }
    }

    var rating: Float? {
        switch self {
        case let .movie(movie):
            return movie.rating
        case let .series(series):
            return series.rating
        case .person:
            return nil
        }
    }

    var title: String {
        switch self {
        case let .movie(movie):
            return movie.title
        case let .series(series):
            return series.title
        case let .person(person):
            return person.title
        }
    }

    var subtitle: String {
        switch self {
        case let .movie(movie):
            return movie.subtitle
        case let .series(series):
            return series.subtitle
        case let .person(person):
            return person.subtitle
        }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let movie = try? container.decode(Movie.self) {
            self = .movie(movie)
        } else if let series = try? container.decode(Series.self) {
            self = .series(series)
        } else if let person = try? container.decode(Person.self) {
            self = .person(person)
        } else {
            fatalError("Media Decoding: Unknow data type!")
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case let .movie(movie):
            try container.encode(movie)
        case let .series(series):
            try container.encode(series)
        case let .person(person):
            try container.encode(person)
        }
    }
}
