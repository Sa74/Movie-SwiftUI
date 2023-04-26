//
//  Person.swift
//  Movie-SwiftUI
//
//  Created by Sasi Moorthy on 15.04.23.
//

import Combine
import Foundation

struct Person: Codable & Identifiable {
    let id: Int
    let name: String
    let originalName: String
    let popularity: Float
    let gender: Int
    let department: String
    let profilePath: String?
    let isAdult: Bool

    var posterUrl: URL? {
        guard let profilePath = profilePath else {
            return nil
        }
        return Endpoint.imageUrl(for: profilePath, with: .w500)
    }

    var title: String {
        return name
    }

    var subtitle: String {
        return department
    }

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case originalName = "original_name"
        case popularity = "popularity"
        case gender = "gender"
        case department = "known_for_department"
        case profilePath = "profile_path"
        case isAdult = "adult"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        originalName = try values.decode(String.self, forKey: .originalName)
        popularity = try values.decode(Float.self, forKey: .popularity)
        gender = try values.decode(Int.self, forKey: .gender)
        department = try values.decode(String.self, forKey: .department)
        profilePath = try values.decode(String?.self, forKey: .profilePath)
        isAdult = try values.decode(Bool.self, forKey: .isAdult)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(originalName, forKey: .originalName)
        try container.encode(popularity, forKey: .popularity)
        try container.encode(gender, forKey: .gender)
        try container.encode(department, forKey: .department)
        try container.encode(profilePath, forKey: .profilePath)
        try container.encode(isAdult, forKey: .isAdult)
    }
}
