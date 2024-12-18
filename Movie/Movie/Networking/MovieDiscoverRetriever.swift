//
//  MovieDiscoverRetriever.swift
//  Movie
//
//  Created by Tushar Arora on 12/12/24.
//

import Foundation
import Alamofire

protocol MovieDiscovery {
    func fetchMovies(page: Int, completion: @escaping (Result<MovieBase, Error>) -> Void)
}

class MovieDiscoveryRetriever: MovieDiscovery {
    
    func fetchMovies(page: Int, completion: @escaping (Result<MovieBase, Error>) -> Void) {
        
        let parameters: [String: String] = [
            "page": "\(page)"
        ]
        
        let url = API.baseURL + API.Endpoint.discoverMovies
        
        APIManager.shared.request(
            url: url,
            method: .get,
            parameters: parameters,
            headers: [API.Headers.Keys.authorization: API.Headers.Values.authorizationToken]
        ) { (result: Result<MovieBase, Error>) in
            switch result {
            case .success((let MovieResponse)):
                completion(.success((MovieResponse)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

class MockMovieDiscoveryRetriever: MovieDiscovery {
    var stubbedFetchMoviesResult: Result<MovieBase, Error>?
    func fetchMovies(page: Int, completion: @escaping (Result<MovieBase, Error>) -> Void) {
        completion(stubbedFetchMoviesResult!)
    }
}
