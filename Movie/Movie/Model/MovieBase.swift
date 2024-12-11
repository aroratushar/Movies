//
//  MovieBase.swift
//  Movie
//
//  Created by Tushar Arora on 12/12/24.
//

import Foundation

struct MovieBase : Codable {
    let page : Int?
    let results : [MovieResults]?
    let total_pages : Int?
    let total_results : Int?

    enum CodingKeys: String, CodingKey {

        case page = "page"
        case results = "results"
        case total_pages = "total_pages"
        case total_results = "total_results"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        page = try values.decodeIfPresent(Int.self, forKey: .page)
        results = try values.decodeIfPresent([MovieResults].self, forKey: .results)
        total_pages = try values.decodeIfPresent(Int.self, forKey: .total_pages)
        total_results = try values.decodeIfPresent(Int.self, forKey: .total_results)
    }
}
