//
//  SearchFieldHandler.swift
//  Movie-SwiftUI
//
//  Created by Sasi Moorthy on 25.04.23.
//

import Combine
import Foundation

final class SearchFieldHandler: ObservableObject {

    @Published var searchText = ""

    private var subscriptions = Set<AnyCancellable>()

    init(searchOperation: ((String) -> Void)?) {
        $searchText
            .debounce(
                for: .seconds(1),
                scheduler: DispatchQueue.main
            )
            .sink(receiveValue: { text in
                searchOperation?(text)
            })
            .store(in: &subscriptions)
    }
}
