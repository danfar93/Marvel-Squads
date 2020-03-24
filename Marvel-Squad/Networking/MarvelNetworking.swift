//
//  MarvelNetworking.swift
//  Marvel-Squad
//
//  Created by Daniel Farrell on 22/03/2020.
//  Copyright © 2020 Daniel Farrell. All rights reserved.
//

import Foundation
import CommonCrypto

class MarvelNetworking {
    
    let marvelBaseUrl = "https://gateway.marvel.com/v1"
    let superherosEndpoint = "/public/characters"
    let comicsEndpoint = "/comics"
    let publicKey = "478f348d322829fb1b71b645d0d64ce5"
    let privateKey = "e59593ab6fc65dabf26c46561eefb7bde6f3b915"
    
    
    /*
     * Makes a GET request to Marvel API and
     * completion returns an array of Superheros
     */
    func retrieveSuperherosFromMarvelAPI(completion: @escaping ([Superheros]) -> ()) {
        
        var superheros = [Superheros]()
        
        let timestamp = Date().timeIntervalSince1970
        let requestString = "?ts=\(timestamp)&apikey=\(publicKey)&hash=\(generateHash(timestamp: timestamp))"
        let url = URL(string: marvelBaseUrl + superherosEndpoint + requestString)
     
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error)
            } else if let json = data {
                let decoder = JSONDecoder()
                do {
                    let superheroResponse = try decoder.decode(SuperheroResponse.self, from: json)
                    superheros = superheroResponse.data!.results
                    superheros.sort { ($0.name as! String) < ($1.name as! String) }
                    completion(superheros)
                } catch {
                    print(error)
                }
            }
        }
        task.resume()
    }
    
    
    /*
     * Makes a GET request to Marvel API and
     * completion returns an array of comics for the superhero
     */
    func retrieveComicsForSuperhero(id: Int, completion: @escaping ([Comics]) -> ()) {
        
        var comics = [Comics]()
        
        let idString = String(id)
        let timestamp = Date().timeIntervalSince1970
        let requestString = "?ts=\(timestamp)&apikey=\(publicKey)&hash=\(generateHash(timestamp: timestamp))"
        let url = URL(string: marvelBaseUrl + superherosEndpoint + "/" + idString + comicsEndpoint + requestString)
     
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error)
            } else if let json = data {
                let decoder = JSONDecoder()
                do {
                    let comicsResponse = try decoder.decode(ComicsResponse.self, from: json)
                    comics = comicsResponse.data!.results
                    completion(comics)
                } catch {
                    print(error)
                }
            }
        }
        task.resume()
    }


    /*
     * Generates MD5 hash using timestamp, privateKey & publicKey
     * Returns: hashString
     */
    private func generateHash(timestamp: TimeInterval) -> String {

        let hashString = MD5(string: "\(timestamp)" + privateKey + publicKey)
        return hashString
    }
    

    /*
     * Helper method for generating MD5 Hash
     * Note: Deprecated in iOS 13 but required by Marvel API
     */
    func MD5(string: String) -> String {
        if let stringData = string.data(using: String.Encoding.utf8) {
            var digest = [UInt8](repeating: 0, count:Int(CC_MD5_DIGEST_LENGTH))
            stringData.withUnsafeBytes {
                CC_MD5($0.baseAddress, UInt32(stringData.count), &digest)
            }
            var md5String = ""
            for byte in digest {
                md5String += String(format:"%02x", UInt8(byte))
            }
            
            return md5String
        }
        return ""
    }
    

    
}

