//
//  MarvelSquadsTests.swift
//  MarvelSquadsTests
//
//  Created by Daniel Farrell on 22/03/2020.
//  Copyright © 2020 Daniel Farrell. All rights reserved.
//

import XCTest

class MarvelSquadsTests: XCTestCase {

    let squadSupport = SquadSupport()
    let thumbnailSupport = ThumbnailSupport()
    let marvelNetworking = MarvelNetworking()
    
    let defaults = UserDefaults.standard
    let defaultsKey = "squadDefaults"

    var squadMembers = [Int]()
    
    override func setUp() {
        squadMembers = [1001, 1002, 1003, 1004, 1005]
        defaults.set(squadMembers, forKey: defaultsKey)
    }

    override func tearDown() {
        squadMembers = []
        defaults.set(squadMembers, forKey: defaultsKey)
    }

    
    /*
     * Tests successful check for superhero in squad
     * Method Under Test: SquadSupport.isSuperheroInSquad()
     * Assert - true
     */
    func testSuperheroInSquadSuccess() {
        var isSuperheroInSquad = Bool()
        let superheroId: Int = 1001
        isSuperheroInSquad = squadSupport.isSuperheroInSquad(superheroId: superheroId)
        
        assert(isSuperheroInSquad)
    }

    
    /*
     * Tests unsuccessful check for superhero in squad
     * Method Under Test: SquadSupport.isSuperheroInSquad()
     * Assert - false
     */
    func testSuperheroInSquadFailure() {
        
        var isSuperheroInSquad = Bool()
        let superheroId: Int = 1010
        isSuperheroInSquad = squadSupport.isSuperheroInSquad(superheroId: superheroId)
        
        assert(!isSuperheroInSquad)
    }
    
    
    /*
     * Tests recruiting a superhero to the squad
     * Method Under Test: SquadSupport.addSquadMember()
     * Assert - true
     */
    func testAddSuperheroToSquad() {
        let superheroId: Int = 1006
        var isSuperheroInSquad = Bool()
        squadSupport.addSquadMember(superheroId: superheroId)
        isSuperheroInSquad = squadSupport.isSuperheroInSquad(superheroId: superheroId)

        assert(isSuperheroInSquad)
    }
    
    
    /*
     * Tests firing a superhero from the squad
     * Method Under Test: SquadSupport.addSquadMember()
     * Assert - false
     */
    func testFiringSuperheroFromSquad() {
        let superheroId: Int = 1002
        var isSuperheroInSquad = Bool()
        squadSupport.removeSquadMember(superheroId: superheroId)
        isSuperheroInSquad = squadSupport.isSuperheroInSquad(superheroId: superheroId)

        assert(!isSuperheroInSquad)
    }
    
    
    /*
     * Tests generating URL String from Thumbnail
     * Method Under Test: ThumbnailSupport.getUrlfromThumbnail()
     * AssertEqual - true
     */
    func testGeneratingURLStringFromThumbnail() {
        let thumbnail = Thumbnail(path: "https://www.marveltest.com/superhero-image", ext: "png")
        let urlString = thumbnailSupport.getUrlfromThumbnail(thumbnail: thumbnail)
        let validURLString = "https://www.marveltest.com/superhero-image.png"

        XCTAssertEqual(urlString, validURLString)
    }
    
    
    /*
     * Tests decoding superheros from Marvel API
     * Method Under Test: SquadSupport.addSquadMember()
     * AssertNotNil - true
     */
    func testDecodingSuperherosFromMarvelAPI() {
        var superherosFromAPI = [Superheros]()
        marvelNetworking.retrieveSuperherosFromMarvelAPI() { superheros in
            superherosFromAPI.append(contentsOf: superheros)
        }
        XCTAssertNotNil(superherosFromAPI)
    }
    
    
    /*
     * Tests decoding comics from Marvel API
     * Method Under Test: SquadSupport.addSquadMember()
     * AssertNotNil - true
     */
    func testDecodingComicsFromMarvelAPI() {
        var comicsFromAPI = [Comics]()
        let superheroId = 1009144
        marvelNetworking.retrieveComicsForSuperhero(id: superheroId) { comics in
            comicsFromAPI.append(contentsOf: comics)
        }
        XCTAssertNotNil(comicsFromAPI)
    }
    
    
}
