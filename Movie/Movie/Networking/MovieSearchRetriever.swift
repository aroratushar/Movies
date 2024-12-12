//
//  MovieSearchRetriever.swift
//  Movie
//
//  Created by Tushar Arora on 12/12/24.
//

import Foundation
import Alamofire

protocol MovieSearch {
    func searchMovies(searchText:String, page: Int, completion: @escaping (Result<MovieBase, AFError>) -> Void)
}

class MovieSearchRetriever: MovieSearch {
    
    func searchMovies(searchText:String, page: Int, completion: @escaping (Result<MovieBase, AFError>) -> Void) {
        
        let parameters: [String: String] = [
            "query": searchText,
            "page": "\(page)"
        ]
        
        let url = API.baseURL + API.Endpoint.searchMovies
        
        APIManager.shared.request(
            url: url,
            method: .get,
            parameters: parameters,
            headers: [API.Headers.Keys.authorization: API.Headers.Values.authorizationToken]
        ) { (result: Result<MovieBase, AFError>) in
            switch result {
            case .success((let MovieResponse)):
                completion(.success((MovieResponse)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
