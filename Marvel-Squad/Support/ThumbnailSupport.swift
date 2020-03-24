//
//  SuperheroSupport.swift
//  Marvel-Squad
//
//  Created by Daniel Farrell on 22/03/2020.
//  Copyright © 2020 Daniel Farrell. All rights reserved.
//

import Foundation
import UIKit


class ThumbnailSupport {
    
    /*
     * Returns urlString used to fetch UIImageView images
     * Parameter: thumbnail
     * Returns: imageURL
     */
    func getUrlfromThumbnail(thumbnail: Thumbnail) -> String {
        let imageNotAvailable = "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available"
        var imageURL = String()
        if (thumbnail.path == imageNotAvailable) {
            imageURL = ""
        } else {
            imageURL = thumbnail.path! + "." + thumbnail.ext!
        }
        return imageURL
    }
    
}
