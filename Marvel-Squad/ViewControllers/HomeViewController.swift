//
//  HomeViewController.swift
//  Marvel-Squad
//
//  Created by Daniel Farrell on 22/03/2020.
//  Copyright © 2020 Daniel Farrell. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet var enterMarvelSquadsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enterMarvelSquadsButton.layer.cornerRadius = 25
    }
    
    /*
     * Button to enter app, provides haptic feedback to the user
     */
    @IBAction func enterMarvelSquadsPressed(_ sender: Any) {
        let impactGenerator = UIImpactFeedbackGenerator(style: .heavy)
        impactGenerator.prepare()
        impactGenerator.impactOccurred()
        performSegue(withIdentifier: "enterMarvelSquadsSegue", sender: nil)
    }
    
}
