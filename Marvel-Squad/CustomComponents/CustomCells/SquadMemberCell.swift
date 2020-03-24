//
//  SquadMemberCell.swift
//  Marvel-Squad
//
//  Created by Daniel Farrell on 22/03/2020.
//  Copyright © 2020 Daniel Farrell. All rights reserved.
//

import UIKit

class SquadMemberCell: UICollectionViewCell {
    
    @IBOutlet var superheroImageView: UIImageView!
    @IBOutlet var superheroNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        superheroImageView.layer.cornerRadius = 28
    }
  
}
