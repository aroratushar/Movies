//
//  MovieTests.swift
//  MovieTests
//
//  Created by Tushar Arora on 10/12/24.
//

import XCTest
@testable import Movie

final class MovieTests: XCTestCase {
    
    private var viewModel: MovieSearchViewModel!
    private var mockDiscoveryRetriever: MockMovieDiscoveryRetriever!
    private var mockSearchRetriever: MockMovieSearchRetriever!
    private var mockMovieStorage: MockMovieStorage!
    
    override func setUpWithError() throws {
        mockDiscoveryRetriever = MockMovieDiscoveryRetriever()
        mockSearchRetriever = MockMovieSearchRetriever()
        mockMovieStorage = MockMovieStorage()
        viewModel = MovieSearchViewModel(retriever: mockDiscoveryRetriever)
        viewModel.movieSearch = mockSearchRetriever
        viewModel.movieStorage = mockMovieStorage
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testFetchMoviesSuccess() {
        let expectedMovies = [
            MovieResults(movieId: 12, title: "Venom", description: "test 1", releaseDate: "01/12/24", posterPath: "test poster1"),
            MovieResults(movieId: 13, title: "superman", description: "test 2", releaseDate: "02/12/24", posterPath: "test poster2"),
            MovieResults(movieId: 14, title: "batman", description: "test 3", releaseDate: "03/12/24", posterPath: "test poster3"),
            MovieResults(movieId: 15, title: "spiderman", description: "test 4", releaseDate: "04/12/24", posterPath: "test poster4")
        ]
        mockDiscoveryRetriever.stubbedFetchMoviesResult = .success(MovieBase(page: 1, results: expectedMovies, total_pages: 10, total_results: 100))
        let expectation = XCTestExpectation(description: "Fetch movies")
        viewModel.onMoviesFetched = {
            XCTAssertEqual(self.viewModel.movies.first?.id, expectedMovies.first?.id)
            expectation.fulfill()
        }
        
        viewModel.fetchMovies()
        wait(for: [expectation], timeout: 1)
    }
    
    func testFetchMoviesFailure() {
        let expectedError = NSError(domain: "TestError", code: 0, userInfo: nil)
        mockDiscoveryRetriever.stubbedFetchMoviesResult = .failure(expectedError)
        
        let expectation = XCTestExpectation(description: "Fetch movies failure")
        viewModel.onError = { error in
            XCTAssertEqual(error, expectedError.localizedDescription)
            expectation.fulfill()
        }
        
        viewModel.fetchMovies()
        wait(for: [expectation], timeout: 1)
    }
    
    func testNumberOfRowsSuccess() {
        let expectedMovies = [
            MovieResults(movieId: 12, title: "Venom", description: "test 1", releaseDate: "01/12/24", posterPath: "test poster1"),
            MovieResults(movieId: 13, title: "superman", description: "test 2", releaseDate: "02/12/24", posterPath: "test poster2"),
        ]
        mockDiscoveryRetriever.stubbedFetchMoviesResult = .success(MovieBase(page: 1, results: expectedMovies, total_pages: 10, total_results: 100))
        viewModel.onMoviesFetched = {
            XCTAssertEqual(self.viewModel.movies.first?.id, expectedMovies.first?.id)
        }
        
        viewModel.fetchMovies()
        XCTAssertEqual(viewModel.numberOfRows(), 2)
    }
    
    func testNumberOfRowsFailure() {
        let expectedMovies = [
            MovieResults(movieId: 12, title: "Venom", description: "test 1", releaseDate: "01/12/24", posterPath: "test poster1"),
            MovieResults(movieId: 13, title: "superman", description: "test 2", releaseDate: "02/12/24", posterPath: "test poster2"),
        ]
        mockDiscoveryRetriever.stubbedFetchMoviesResult = .success(MovieBase(page: 1, results: expectedMovies, total_pages: 10, total_results: 100))
        viewModel.onMoviesFetched = {
            XCTAssertEqual(self.viewModel.movies.first?.id, expectedMovies.first?.id)
        }
        
        viewModel.fetchMovies()
        XCTAssertNotEqual(viewModel.numberOfRows(), 5)
    }
    
    func testMovieAtIndex() {
        let expectedMovies = [
            MovieResults(movieId: 12, title: "Venom", description: "test 1", releaseDate: "01/12/24", posterPath: "test poster1"),
            MovieResults(movieId: 13, title: "superman", description: "test 2", releaseDate: "02/12/24", posterPath: "test poster2"),
        ]
        mockDiscoveryRetriever.stubbedFetchMoviesResult = .success(MovieBase(page: 1, results: expectedMovies, total_pages: 10, total_results: 100))
        viewModel.onMoviesFetched = {
            XCTAssertEqual(self.viewModel.movies.first?.id, expectedMovies.first?.id)
        }
        
        viewModel.fetchMovies()
        let movie = viewModel.movie(at: 1)
        XCTAssertEqual(movie.title, "superman")
    }
    
    func testSaveMovieToFavourite() {
        let movie = MovieResults(movieId: 12, title: "Venom", description: "test 1", releaseDate: "01/12/24", posterPath: "test poster1")
        viewModel.saveMovieToFavorites(movie)
        XCTAssertEqual(viewModel.isMovieInFavorites(movie), true)
    }
    
    func testRemoveMovieFromFavourite() {
        let movie = MovieResults(movieId: 12, title: "Venom", description: "test 1", releaseDate: "01/12/24", posterPath: "test poster1")
        viewModel.saveMovieToFavorites(movie)
        XCTAssertEqual(viewModel.favoriteMovies.count, 2)
        viewModel.removeMovieFromFavorites(movie)
        XCTAssertEqual(viewModel.favoriteMovies.count, 1)
    }
    
    func testFetchFavouriteMovies() {
        let movie = MovieResults(movieId: 44, title: "BatMan", description: "test 1", releaseDate: "01/12/24", posterPath: "test poster1")
        viewModel.saveMovieToFavorites(movie)
        let totalFavouriteCount = viewModel.fetchFavoriteMovies
        XCTAssertEqual(viewModel.favoriteMovies.count, 2)

    }
        
}
