//
//  Thumbnail.swift
//  Marvel-Squad
//
//  Created by Popdeem on 23/03/2020.
//  Copyright © 2020 Popdeem. All rights reserved.
//

import Foundation

struct Thumbnail: Codable {
    let path : String?
    let ext : String?
    
    enum CodingKeys: String, CodingKey {
        case path = "path"
        case ext = "extension"
    }
}
