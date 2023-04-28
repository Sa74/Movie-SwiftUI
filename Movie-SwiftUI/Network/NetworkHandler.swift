//
//  NetworkHandler.swift
//  Movie-SwiftUI
//
//  Created by Sasi Moorthy on 22.04.23.
//

import Foundation
import Combine

protocol NetworkProtocol {
    func fetchData<T: Codable>(from url: URL) async throws -> T?
    func fetchHTMLString(from url: URL) async throws -> String?
}

final class NetworkHandler: NetworkProtocol {

    private let urlSession: URLSession
    var subscriptions = Set<AnyCancellable>()

    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }

    func fetchData<T: Codable>(from url: URL) async throws -> T? {
        try await withCheckedThrowingContinuation { continuation in
            urlSession.publisher(
                for: url,
                responseType: T.self,
                decoder: JSONDecoder()
            )
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case let .failure(error):
                        continuation.resume(throwing: error)
                    case .finished:
                        break
                    }
                }
            ) { model in
                continuation.resume(returning: model)
            }
            .store(in: &subscriptions)
        }
    }

    func fetchHTMLString(
        from url: URL
    ) async throws -> String? {
        try await withCheckedThrowingContinuation { continuation in
            let request = URLRequest(
                url: url,
                cachePolicy: .returnCacheDataElseLoad,
                timeoutInterval: 30
            )
            let task = urlSession.dataTask(
                with: request
            ) { data, _, error in
                if let error = error {
                    continuation.resume(
                        throwing: error
                    )
                }
                guard let data = data,
                    let htmlString = String(
                        data: data,
                        encoding: .utf8
                    ) else {
                    return
                }
                continuation.resume(
                    returning: htmlString
                )
            }
            task.resume()
        }
    }
}
