//
//  Service.swift
//  Pokedex
//
//  Created by wtildestar on 17/01/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import Foundation

class Service {
    
    static let shared = Service()
    let baseUrl = "https://pokedex-417cb.firebaseio.com/.json"
    
    func fetchPokemon() {
        
        guard let url = URL(string: baseUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                print("Failed to fetch data with error: ", error.localizedDescription)
                return
            }
            
            guard let data = data else { return }
            
            do {
                guard let resultArray = try JSONSerialization.jsonObject(with: data, options: []) as? [AnyObject] else { return }
                
                for (key, result) in resultArray.enumerated() {
                    if let dictionary = result as? [String : AnyObject] {
                        let pokemon = Pokemon(id: key, dictionary: dictionary)
                        print(pokemon.name!)
                    }
                }
                
            } catch let error {
                print("Failed to create JSON with error: ", error.localizedDescription)
            }
            
        }.resume()
        
    }
}
