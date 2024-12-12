//
//  MovieCastRetriever.swift
//  Movie
//
//  Created by Tushar Arora on 12/12/24.
//

import Foundation
import Alamofire

protocol MovieCast {
    func fetchMovieCast(movieId: Int, completion: @escaping (Result<MovieCastModel, Error>) -> Void)
}

class MovieCastRetriever: MovieCast {
    
    func fetchMovieCast(movieId: Int, completion: @escaping (Result<MovieCastModel, Error>) -> Void) {
        
        let url = API.baseURL + API.Endpoint.movieDetail + String(movieId) + API.Endpoint.movieCast
        
        APIManager.shared.request(
            url: url,
            method: .get,
            parameters: nil,
            headers: [API.Headers.Keys.authorization: API.Headers.Values.authorizationToken]
        ) { (result: Result<MovieCastModel, Error>) in
            switch result {
            case .success((let MovieCastResponse)):
                completion(.success((MovieCastResponse)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
