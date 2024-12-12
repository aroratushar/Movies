//
//  MovieCast.swift
//  Movie
//
//  Created by Tushar Arora on 12/12/24.
//

import Foundation

struct MovieCastModel : Codable {
    let id : Int?
    let cast : [Cast]?
    let crew : [Crew]?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case cast = "cast"
        case crew = "crew"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        cast = try values.decodeIfPresent([Cast].self, forKey: .cast)
        crew = try values.decodeIfPresent([Crew].self, forKey: .crew)
    }

}
