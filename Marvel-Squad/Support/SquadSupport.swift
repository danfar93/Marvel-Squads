//
//  SquadSupport.swift
//  Marvel-Squad
//
//  Created by Daniel Farrell on 22/03/2020.
//  Copyright © 2020 Daniel Farrell. All rights reserved.
//

import Foundation
 
class SquadSupport {
    
    let defaults = UserDefaults.standard
    let defaultsKey = "squadDefaults"
    
    /*
     * Add superhero to the squad
     * Parameter: superheroId
     */
    func addSquadMember(superheroId: Int) {
        var squadMembers = [Int]()
        squadMembers = defaults.array(forKey: defaultsKey) as? [Int] ?? []
        squadMembers.append(superheroId)
        defaults.set(squadMembers, forKey: defaultsKey)
    }
    
    
    /*
     * Remove superhero from the squad
     * Parameter: superheroId
     */
    func removeSquadMember(superheroId: Int) {
        var squadMembers = [Int]()
        squadMembers = defaults.array(forKey: defaultsKey) as? [Int] ?? []
        let updatedSquad = squadMembers.filter {$0 != superheroId}
        defaults.set(updatedSquad, forKey: defaultsKey)
    }
    

    /*
     * Validate if superhero is in squad
     * Parameter: superheroId
     * Returns: Bool
     */
    func isSuperheroInSquad(superheroId: Int) -> Bool {
        var isSquadMember = Bool()
        var squadMembers = [Int]()
        squadMembers = defaults.array(forKey: defaultsKey) as? [Int] ?? []
        if (squadMembers.contains(superheroId)) {
           isSquadMember = true
        } else {
           isSquadMember = false
        }
        return isSquadMember
    }

    
}
