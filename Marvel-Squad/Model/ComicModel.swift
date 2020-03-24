//
//  ComicModel.swift
//  Marvel-Squad
//
//  Created by Popdeem on 23/03/2020.
//  Copyright © 2020 Popdeem. All rights reserved.
//

import Foundation

struct ComicsResponse: Codable {
    var data: ComicsData?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
}

struct ComicsData: Codable {
    var results: [Comics]
    var count: Int
    
    enum CodingKeys: String, CodingKey {
        case results = "results"
        case count = "count"
    }
}

struct Comics: Codable {
    let title : String?
    let thumbnail : Thumbnail?

    enum CodingKeys: String, CodingKey {
        case title = "title"
        case thumbnail = "thumbnail"
    }
}


