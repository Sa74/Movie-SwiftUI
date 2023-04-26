//
//  NetworkMock.swift
//  Movie-SwiftUITests
//
//  Created by Sasi Moorthy on 22.04.23.
//

import Foundation

@testable import Movie_SwiftUI

final class NetworkingMock: NetworkProtocol {

    var result = Result<Codable, Error>.success(Data())

    func fetchData<T: Codable>(
        from url: URL
    ) async throws -> T? {
        try result.get() as? T
    }
}
