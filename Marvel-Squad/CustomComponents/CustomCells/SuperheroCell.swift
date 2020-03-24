//
//  SuperheroCell.swift
//  Marvel-Squad
//
//  Created by Daniel Farrell on 22/03/2020.
//  Copyright © 2020 Daniel Farrell. All rights reserved.
//

import UIKit

class SuperheroCell: UITableViewCell {

    
    @IBOutlet var cellBackgroundView: UIView!
    @IBOutlet var superheroImageView: UIImageView!
    @IBOutlet var superheroNameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupView() {
        cellBackgroundView.layer.cornerRadius = 15
        superheroImageView.layer.cornerRadius = 40
    }

}

