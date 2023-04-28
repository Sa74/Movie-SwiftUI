//
//  Video.swift
//  Movie-SwiftUI
//
//  Created by Sasi Moorthy on 27.04.23.
//

import Foundation

struct Video: Hashable & Identifiable {
    let id: String
    let media: String
    let dataId: String
    let title: String
    let subtitle: String
    let thumbnailPath: String

    var thumbnailUrl: URL {
        return Endpoint.imageUrl(for: thumbnailPath, with: .w500)
    }

    var videoUrl: URL {
        return Endpoint.youTubeVideoUrl(for: dataId)
    }
}
