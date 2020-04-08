//
//  SuperheroDetailViewController.swift
//  Marvel-Squad
//
//  Created by Daniel Farrell on 22/03/2020.
//  Copyright © 2020 Daniel Farrell. All rights reserved.
//

import UIKit


class SuperheroDetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet var superheroImageView: UIImageView!
    @IBOutlet var superheroNameLabel: UILabel!
    @IBOutlet var recruitToSquadButton: UIButton!
    @IBOutlet var superheroDescriptionLabel: UILabel!
    @IBOutlet var comicCollectionView: UICollectionView!
    @IBOutlet var lastAppearedInLabel: UILabel!
    
    var superheroComicsArray = [Comics]()
    var isSquadMember = Bool()
    var passedSuperheroName = String()
    var passedSuperheroId = Int()
    var passedSuperheroDescription = String()
    var passedSuperheroImageURL = String()
    
    let notificationGenerator = UINotificationFeedbackGenerator()
    let service = MarvelNetworking()
    let thumbnailSupport = ThumbnailSupport()
    let squadSupport = SquadSupport()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getComicsForSuperhero(superheroId: passedSuperheroId)
        squadUpdatesNotifcationObservers()
        setupView()
    }
    
    
    /*
     * Setup SuperheroDetailViewController View
     */
    func setupView() {
        superheroNameLabel.text = passedSuperheroName
        if (!passedSuperheroDescription.isEmpty) {
            superheroDescriptionLabel.text = passedSuperheroDescription
        } else {
            superheroDescriptionLabel.text = "There is currently no description available for this Marvel Superhero"
        }
        superheroImageView.downloaded(from: passedSuperheroImageURL)
        recruitToSquadButton.layer.cornerRadius = 25
        updateUIButtonOptions()
    }
    
    
    /*
     * Make call to Marvel API and populate collection view with comics
     * Parameter: superheroId
     */
    func getComicsForSuperhero(superheroId: Int) {
        service.retrieveComicsForSuperhero(id: superheroId) { comics in
            self.superheroComicsArray.append(contentsOf: comics)
            DispatchQueue.main.async {
                self.updateNumberComicsLabel(numberOfComics: comics.count)
                self.comicCollectionView.reloadData()
                
            }
        }
    }
    
    
    /*
     * Checks if Superhero is in the squad
     */
    func checkSuperheroInSquad() -> Bool {
        return squadSupport.isSuperheroInSquad(superheroId: passedSuperheroId)
    }
    
    
    /*
     * Buton recruits or fires a squad member based on
     * their current status
     */
    @IBAction func recruitButtonPressed(_ sender: Any) {
        if (checkSuperheroInSquad()) {
            notificationGenerator.notificationOccurred(.warning)
            showConfirmationPopup()
        } else {
            notificationGenerator.notificationOccurred(.success)
            squadSupport.addSquadMember(superheroId: passedSuperheroId)
            NotificationCenter.default.post(name: Notification.Name("RecruitSquadMemberNotification"), object: nil)
        }
    }
    
    
    /*
     * Fires squad member from UserDefaults & updates the UI in the main thread
     * Parameter: NSNotification
     */
    @objc func fireSquadMemberUpdateUI(notification: NSNotification) {
        squadSupport.removeSquadMember(superheroId: passedSuperheroId)
        DispatchQueue.main.async {
            self.updateUIButtonOptions()
        }
    }
    
    
    /*
     * Updates the UI in the main thread after recruitinga superhero to the squad
     * Parameter: NSNotification
     */
    @objc func recruitSquadMemberUpdateUI(notification: NSNotification) {
        DispatchQueue.main.async {
            self.updateUIButtonOptions()
        }
    }
    
    
    /*
     * Limits the number of comics in UICollectionView to 2
     */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return superheroComicsArray.count > 2 ? 2 : superheroComicsArray.count
    }
    
    
    /*
     * Populate custom UICollectionViewCell - ComicCell
     */
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionViewCell = comicCollectionView.dequeueReusableCell(withReuseIdentifier: "comicCell", for: indexPath) as! ComicCell
        collectionViewCell.comicTitleLabel.text = superheroComicsArray[indexPath.row].title
        let imageURL = thumbnailSupport.getUrlfromThumbnail(thumbnail: superheroComicsArray[indexPath.row].thumbnail!)
        collectionViewCell.comicCoverImageView.downloaded(from: imageURL)
        
        return collectionViewCell
    }
    

    /*
     * Updates UI of recruit/fire button when
     * action occurs
     */
    func updateUIButtonOptions() {
        if (checkSuperheroInSquad()) {
            let redColor = UIColor.red
            recruitToSquadButton.setTitle("🔥 Fire from Squad", for: .normal)
            recruitToSquadButton.layer.borderColor = redColor.cgColor
            recruitToSquadButton.backgroundColor = UIColor.clear
            recruitToSquadButton.layer.borderWidth = 3.0
        } else {
            recruitToSquadButton.setTitle("💪 Recruit to Squad", for: .normal)
            recruitToSquadButton.backgroundColor = UIColor.red
        }
    }
    
    
    /*
     * Observers listening for NSNotifications
     */
    func squadUpdatesNotifcationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.fireSquadMemberUpdateUI), name: NSNotification.Name(rawValue: "FireSquadMemberNotification"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.recruitSquadMemberUpdateUI), name: NSNotification.Name(rawValue: "RecruitSquadMemberNotification"), object: nil)
    }
    
    
    /*
     * Checks how many comics a superhero appears in
     * and updates the lastAppearedInLabel
     */
    func updateNumberComicsLabel(numberOfComics: Int) {
        if (numberOfComics > 2) {
            let remainingcomics =  numberOfComics - 2
            lastAppearedInLabel.text = "Last appeared in (\(remainingcomics) others)"
        } else {
            lastAppearedInLabel.text = "Last appeared in"
        }
    }
    
    
    /*
     * Displays custom alter view to user - MSAlertViewController
     */
    func showConfirmationPopup() {
        presentMSAlertOnMainThread(title: "Fire Superhero 🔥",
                                   message: "Are you sure you want to fire this superhero from your squad?",
                                   dismissButtonTitle: "No, keep them!",
                                   confirmButtonTitle: "Yes, fire them!")
    }
    

}
