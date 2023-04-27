//
//  Movie_SwiftUIApp.swift
//  Movie-SwiftUI
//
//  Created by Sasi Moorthy on 11.04.23.
//

import SwiftUI

@main
struct Movie_SwiftUIApp: App {

    var body: some Scene {
        WindowGroup {
            MediaFeedView(
                viewModel: MediaFeedViewModel(
                    mediaFetcher: MediaFetcher(),
                    htmlVideoFetcher: HTMLVideoFetcher()
                )
            )
        }
    }
}
