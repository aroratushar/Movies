//
//  MovieDetailRetriever.swift
//  Movie
//
//  Created by Tushar Arora on 12/12/24.
//

import Foundation
import Alamofire

protocol MovieDetail {
    func getMovieDetail(movieId: Int, completion: @escaping (Result<MovieDetailModel, AFError>) -> Void)
}

class MovieDetailRetriever: MovieDetail {
    
    func getMovieDetail(movieId: Int, completion: @escaping (Result<MovieDetailModel, AFError>) -> Void) {
        
        let url = API.baseURL + API.Endpoint.movieDetail + String(movieId)
        
        APIManager.shared.request(
            url: url,
            method: .get,
            parameters: nil,
            headers: [API.Headers.Keys.authorization: API.Headers.Values.authorizationToken]
        ) { (result: Result<MovieDetailModel, AFError>) in
            switch result {
            case .success((let MovieResponse)):
                completion(.success((MovieResponse)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
