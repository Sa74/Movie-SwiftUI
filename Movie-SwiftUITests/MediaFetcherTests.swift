//
//  MediaFetcherTests.swift
//  Movie-SwiftUITests
//
//  Created by Sasi Moorthy on 11.04.23.
//

import XCTest

@testable import Movie_SwiftUI

final class MediaFetcherTests: XCTestCase {

    private var networkHandler: NetworkingMock!
    private var mediaFetcher: MediaFetcher!
    private var testBundle: Bundle!

    override func setUp() {
        super.setUp()

        networkHandler = NetworkingMock()
        mediaFetcher = MediaFetcher(networkHandler: networkHandler)
        testBundle = Bundle(for: type(of: self))
    }

    func testFetchTredningMovieList() async throws {
        try makeResultMock(from: "trending_media_list_movie.json")

        let movieList = try await mediaFetcher.fetchTrendingMedias(
            for: .movie,
            within: .week
        )

        let movie = movieList?.results[1]
        XCTAssertEqual(movie?.id, 76600)
        XCTAssertEqual(movie?.title, "Avatar: The Way of Water")
        XCTAssertEqual(movie?.subtitle, "2022-12-14")
        XCTAssertEqual(movie?.posterUrl?.absoluteString, "http://image.tmdb.org/t/p/w500/t6HIqrRAclMCA60NsSmeqe9RmNV.jpg")
        XCTAssertEqual(movie?.rating, 7.724)

        XCTAssertEqual(movieList?.results.count, 20)
        XCTAssertEqual(movieList?.page, 1)
        XCTAssertEqual(movieList?.totalResults, 20000)
        XCTAssertEqual(movieList?.totalPages, 1000)
    }

    func testFetchTredningPersonList() async throws {
        try makeResultMock(from: "trending_media_list_person.json")

        let movieList = try await mediaFetcher.fetchTrendingMedias(
            for: .movie,
            within: .week
        )

        let person = movieList?.results[1]
        XCTAssertEqual(person?.id, 500)
        XCTAssertEqual(person?.title, "Tom Cruise")
        XCTAssertEqual(person?.subtitle, "Acting")
        XCTAssertEqual(person?.posterUrl?.absoluteString, "http://image.tmdb.org/t/p/w500/8qBylBsQf4llkGrWR3qAsOtOU8O.jpg")
        XCTAssertNil(person?.rating)

        XCTAssertEqual(movieList?.results.count, 19)
        XCTAssertEqual(movieList?.page, 1)
        XCTAssertEqual(movieList?.totalResults, 20000)
        XCTAssertEqual(movieList?.totalPages, 1000)
    }

    private func makeResultMock(from filePath: String) throws {
        let data = try XCTUnwrap(testBundle.contentsOfFile(named: filePath))
        networkHandler.result = try .success(JSONDecoder().decode(MediaList.self, from: data))
    }
}
