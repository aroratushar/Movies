//
//  MovieSearchViewModel.swift
//  Movie
//
//  Created by Tushar Arora on 12/12/24.
//

import Foundation

class MovieSearchViewModel {
    
    var movieStorage: MoviePersistance
    var movieDiscovery: MovieDiscovery
    var movieSearch: MovieSearch
    private(set) var movies: [MovieResults] = []
    private var currentPage = 1
    private var isLoading = false
    private(set) var favoriteMovies: [MovieResults] = []
    
    var onMoviesFetched: (() -> Void)?
    var onError: ((String) -> Void)?
    
    init(retriever: MovieDiscovery = MovieDiscoveryRetriever()) {
        movieDiscovery = retriever
        movieSearch = MovieSearchRetriever()
        movieStorage = MovieStorage()
    }
    
    func fetchMovies(reset: Bool = false) {
        guard !isLoading else { return }
        if reset {
            currentPage = 1
            movies = []
        }
        
        isLoading = true
        movieDiscovery.fetchMovies(page: currentPage) { [weak self] result in
            
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case .success((let movieBase)):
                if let moviesResults = movieBase.results {
                    self.movies.append(contentsOf: moviesResults)
                }
         
                self.currentPage += 1
                self.onMoviesFetched?()
            case .failure(let error):
                self.onError?(error.localizedDescription)
            }
        }
        
    }
    
    func searchMovies(searchText: String, reset: Bool = false) {
        guard !isLoading else { return }
        
        if reset {
            currentPage = 1
            movies = []
        }
        
        isLoading = true
        movieSearch.searchMovies(searchText: searchText, page: currentPage) { [weak self] result in
            
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case .success((let movieBase)):
                if let moviesResults = movieBase.results {
                    self.movies.append(contentsOf: moviesResults)
                }
         
                self.currentPage += 1
                self.onMoviesFetched?()
            case .failure(let error):
                self.onError?(error.localizedDescription)
            }
        }
    }
    
    func numberOfRows() -> Int {
        return movies.count
    }
    
    func movie(at index: Int) -> MovieResults {
        return movies[index]
    }
    
    func fetchFavoriteMovies() {
        favoriteMovies = movieStorage.getFavoriteMovies()
    }
    
    func saveMovieToFavorites(_ movie: MovieResults) {
        movieStorage.saveMovieToFavorites(movie)
        fetchFavoriteMovies()
    }
    
    func removeMovieFromFavorites(_ movie: MovieResults) {
        movieStorage.removeMovieFromFavorites(movie)
        fetchFavoriteMovies()
    }
    
    func isMovieInFavorites(_ movie: MovieResults) -> Bool {
        return movieStorage.isMovieInFavorites(movie)
    }
    
}
