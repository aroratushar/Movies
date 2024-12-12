//
//  MovieDetailViewModel.swift
//  Movie
//
//  Created by Tushar Arora on 12/12/24.
//

import Foundation

class MovieDetailViewModel {
    
    private var movieDetail: MovieDetailRetriever
    private var castRetriever = MovieCastRetriever()
    private(set) var movieDetailModel: MovieDetailModel?
    private(set) var movieCastModel: MovieCastModel?

    
    var onMovieDetailFetched: (() -> Void)?
    var onError: ((String) -> Void)?
    var onMovieCastDetailFetched: (() -> Void)?
    
    init(retriever: MovieDetailRetriever = MovieDetailRetriever()) {
        movieDetail = retriever
    }
    
    func fetchMovieDetail(movieId: Int) {
        movieDetail.getMovieDetail(movieId: movieId) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success((let movieDetail)):
                movieDetailModel = movieDetail
                self.onMovieDetailFetched?()
            case .failure(let error):
                self.onError?(error.localizedDescription)
            }
        }
    }
    
    func fetchMovieCastDetail(movieId: Int) {
        castRetriever.fetchMovieCast(movieId: movieId) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success((let movieCast)):
                movieCastModel = movieCast
                self.onMovieCastDetailFetched?()
            case .failure(let error):
                self.onError?(error.localizedDescription)
            }
        }
    }

}
