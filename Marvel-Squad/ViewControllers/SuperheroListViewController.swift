//
//  SuperheroListViewController.swift
//  Marvel-Squad
//
//  Created by Daniel Farrell on 22/03/2020.
//  Copyright © 2020 Daniel Farrell. All rights reserved.
//

import UIKit

class SuperheroListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var superherosFromAPI = [Superheros]()
    var allSuperheros = [Superheros]()
    var squadMembersArray = [Superheros]()
    
    let defaults = UserDefaults.standard
    let defaultsKey = "squadDefaults"
    let impactGenerator = UIImpactFeedbackGenerator(style: .medium)
    let service = MarvelNetworking()
    let thumbnailSupport = ThumbnailSupport()
    
    @IBOutlet var headerView: UIView!
    @IBOutlet var squadCollectionView: UICollectionView!
    @IBOutlet var superheroTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
 
        setupView()
        fetchSuperherosForTableView()
        populateSquadMembers()
    }
    
    
    /*
     * Make call to Marvel API and populate table view with
     * Superheros in alphabetical order
     */
    func fetchSuperherosForTableView() {
        service.retrieveSuperherosFromMarvelAPI() { superheros in
            self.superherosFromAPI.append(contentsOf: superheros)
            DispatchQueue.main.async {
                self.superheroTableView.reloadData()
            }
        }
    }

    
    /*
     * Populates squad members collection view
     */
    func populateSquadMembers() {
        service.retrieveSuperherosFromMarvelAPI() { superheros in
            self.allSuperheros.append(contentsOf: superheros)
            let squadMemberIds = self.defaults.array(forKey: self.defaultsKey) as? [Int] ?? []
            for superhero in self.allSuperheros {
                if(squadMemberIds.contains(superhero.id!)) {
                    self.squadMembersArray.append(superhero)
                }
            }
            DispatchQueue.main.async {
                self.squadCollectionView.reloadData()
            }
        }
    }
    
    
    /*
     * Setup SuperheroListViewController Views
     */
    func setupView() {
        let logoimage = UIImage(named: "marvel-logo")
        let headerImageView = UIImageView(image: logoimage)
        headerView.addSubview(headerImageView)
        headerImageView.center = CGPoint(x: headerView.frame.size.width  / 2,
                                         y: headerView.frame.size.height / 1.5)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return superherosFromAPI.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }
    
    
    /*
     * Populate custom UITableViewCell - SuperheroCell
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = superheroTableView.dequeueReusableCell(withIdentifier: "superheroCell") as! SuperheroCell
        tableViewCell.selectionStyle = .none
        tableViewCell.superheroNameLabel.text = superherosFromAPI[indexPath.row].name
        let imageURL = thumbnailSupport.getUrlfromThumbnail(thumbnail: superherosFromAPI[indexPath.row].thumbnail!)
        tableViewCell.superheroImageView.downloaded(from: imageURL)
        
        return tableViewCell
    }
    
    
    /*
     * Prepare for segue & pass valuest to SuperheroDetailViewController
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "superheroDetailSegue") {
            impactGenerator.prepare()
            impactGenerator.impactOccurred()
            let superheroDetailView = segue.destination as? SuperheroDetailViewController
            if let indexPath = self.superheroTableView.indexPathForSelectedRow {
                let selectedSuperheroId = self.superherosFromAPI[indexPath.row].id
                let selectedSuperheroName = self.superherosFromAPI[indexPath.row].name
                let selectedSuperheroDesc = self.superherosFromAPI[indexPath.row].description
                let thumbnail = self.superherosFromAPI[indexPath.row].thumbnail
                let selectedSuperheroImageURL = thumbnailSupport.getUrlfromThumbnail(thumbnail: thumbnail!)
                superheroDetailView!.passedSuperheroId = selectedSuperheroId!
                superheroDetailView!.passedSuperheroName = selectedSuperheroName!
                superheroDetailView!.passedSuperheroDescription = selectedSuperheroDesc!
                superheroDetailView!.passedSuperheroImageURL = selectedSuperheroImageURL
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "superheroDetailSegue", sender: self)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return squadMembersArray.count
    }
    
    
    /*
     * Populate custom UICollectionViewCell - SquadMemberCell
     */
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionViewCell = squadCollectionView.dequeueReusableCell(withReuseIdentifier: "squadMemberCell", for: indexPath) as! SquadMemberCell
        collectionViewCell.superheroNameLabel.text = squadMembersArray[indexPath.row].name
        let imageURL = thumbnailSupport.getUrlfromThumbnail(thumbnail: squadMembersArray[indexPath.row].thumbnail!)
        collectionViewCell.superheroImageView.downloaded(from: imageURL)
        
        return collectionViewCell
    }

}


