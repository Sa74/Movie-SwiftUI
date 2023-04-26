//
//  Image+PlaceHolder.swift
//  Movie-SwiftUI
//
//  Created by Sasi Moorthy on 25.04.23.
//

import SwiftUI

extension Image {
    
    static var placeholderUrl: URL {
        guard let placeholderUrl = Bundle.main.url(
            forResource: "placeholder.jpg",
            withExtension: nil
        ) else {
            preconditionFailure("Placeholder image is not found!")
        }

        return placeholderUrl
    }
}
