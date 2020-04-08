//
//  SuperheroModel.swift
//  Marvel-Squad
//
//  Created by Daniel Farrell on 22/03/2020.
//  Copyright © 2020 Daniel Farrell. All rights reserved.
//

import Foundation

struct SuperheroResponse: Codable {
    var data: SuperheroData?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
}

struct SuperheroData: Codable {
    var results: [Superheros]
    
    enum CodingKeys: String, CodingKey {
        case results = "results"
    }
}

struct Superheros: Codable {
    let id : Int?
    let name : String?
    let description : String?
    let thumbnail : Thumbnail?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case description = "description"
        case thumbnail = "thumbnail"
    }
}


