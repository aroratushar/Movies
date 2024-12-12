//
//  MovieDetailRetriever.swift
//  Movie
//
//  Created by Tushar Arora on 12/12/24.
//

import Foundation
import Alamofire

protocol MovieDetail {
    func getMovieDetail(movieId: Int, completion: @escaping (Result<MovieDetailModel, Error>) -> Void)
}

class MovieDetailRetriever: MovieDetail {
    
    func getMovieDetail(movieId: Int, completion: @escaping (Result<MovieDetailModel, Error>) -> Void) {
        
        let url = API.baseURL + API.Endpoint.movieDetail + String(movieId)
        
        APIManager.shared.request(
            url: url,
            method: .get,
            parameters: nil,
            headers: [API.Headers.Keys.authorization: API.Headers.Values.authorizationToken]
        ) { (result: Result<MovieDetailModel, Error>) in
            switch result {
            case .success((let MovieResponse)):
                completion(.success((MovieResponse)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

class MockMovieDetailRetriever: MovieDetail {
    var stubbedMovieDetailResult: Result<MovieDetailModel, Error>?
    func getMovieDetail(movieId: Int, completion: @escaping (Result<MovieDetailModel, Error>) -> Void) {
        completion(stubbedMovieDetailResult!)
    }
}
