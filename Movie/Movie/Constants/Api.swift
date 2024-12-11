//
//  Api.swift
//  Movie
//
//  Created by Tushar Arora on 11/12/24.
//

import Foundation

struct API {
    static let baseURL = "https://api.themoviedb.org/3/"
    static let imageBaseUrl = "https://image.tmdb.org/t/p/original/"
    
    struct Headers {
        struct Keys {
            static let authorization = "Authorization"
        }
        
        struct Values {
            static let applicationJson = "application/json"
            static let applicationFormUrlEncoded = "application/x-www-form-urlencoded"
            static let authorizationToken = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzMjNiYzk4MjZjYzFhMGIxODEzZjk1OGY4MjM0OTZlNiIsIm5iZiI6MTczMzg0Nzc4MS41Nywic3ViIjoiNjc1ODZhZTUzNjg4NDU5ZDc1ODlhN2U5Iiwic2NvcGVzIjpbImFwaV9yZWFkIl0sInZlcnNpb24iOjF9.QtcOX0JP3E9ek45ER6B3rOIiR0A8U-3HOb8XQtxA9Po"
        }
    }
}

