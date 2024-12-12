//
//  MovieStorage.swift
//  Movie
//
//  Created by Tushar Arora on 13/12/24.
//

import Foundation

class MovieStorage {
    
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
