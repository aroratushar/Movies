//
//  MovieStorage.swift
//  Movie
//
//  Created by Tushar Arora on 13/12/24.
//

import Foundation

protocol MoviePersistance {
    func saveMovieToFavorites(_ movie: MovieResults)
    func getFavoriteMovies() -> [MovieResults]
    func removeMovieFromFavorites(_ movie: MovieResults)
    func isMovieInFavorites(_ movie: MovieResults) -> Bool
}

class MovieStorage: MoviePersistance {
    
    private let coreDataManager = CoreDataManager.shared
    
    func saveMovieToFavorites(_ movie: MovieResults) {
        coreDataManager.saveMovie(movie)
    }
    
    func getFavoriteMovies() -> [MovieResults] {
        return coreDataManager.fetchFavoriteMovies()
    }
    
    func removeMovieFromFavorites(_ movie: MovieResults) {
        coreDataManager.deleteMovie(movie)
    }
    
    func isMovieInFavorites(_ movie: MovieResults) -> Bool {
        coreDataManager.isMovieInFavorites(movie)
    }
}

class MockMovieStorage: MoviePersistance {
    var movies: [MovieResults] = [
        MovieResults(movieId: 33, title: "SuperMan", description: "superman test", releaseDate: "21/12/2024", posterPath: "test Path")
    ]
    
    func saveMovieToFavorites(_ movie: MovieResults) {
        movies.append(movie)
    }
    
    func getFavoriteMovies() -> [MovieResults] {
        movies
    }
    
    func removeMovieFromFavorites(_ movie: MovieResults) {
        if let index = movies.firstIndex(where: {$0.id == movie.id}) {
            movies.remove(at: index)
        }
    }
    
    func isMovieInFavorites(_ movie: MovieResults) -> Bool {
        if let _ = movies.firstIndex(where: {$0.id == movie.id}) {
            return true
        }
        return false
    }
}
