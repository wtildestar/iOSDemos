//
//  Service.swift
//  Pokedex
//
//  Created by wtildestar on 17/01/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import UIKit

class Service {
    
    static let shared = Service()
    let baseUrl = "https://pokedex-417cb.firebaseio.com/.json"
    
    func fetchPokemon(completion: @escaping ([Pokemon]) -> ()) {
        
        var pokemonArray = [Pokemon]()
        
        guard let url = URL(string: baseUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                print("Failed to fetch data with error: ", error.localizedDescription)
                return
            }
            
            guard let data = data else { return }
            
            do {
                guard let resultArray = try JSONSerialization.jsonObject(with: data, options: []) as? [AnyObject] else { return }
                
                // перебираю полученный массив на id (key) и хештаблицу [String : AnyObject] (dictionary)
                for (key, result) in resultArray.enumerated() {
                    if let dictionary = result as? [String : AnyObject] {
                        let pokemon = Pokemon(id: key, dictionary: dictionary)
                        
                        guard let imageUrl = pokemon.imageUrl else { return }
                        
                        self.fetchImage(withUrlString: imageUrl) { (image) in
                            // передаю image с приватной функции fetchImage в экземпляр pokemon свойству image
                            pokemon.image = image
                            pokemonArray.append(pokemon)
                            
                            // сортировка
                            pokemonArray.sort { (poke1, poke2) -> Bool in
                                return poke1.id! < poke2.id!
                            }
                            
                            completion(pokemonArray)
                        }
                    }
                }
                
            } catch let error {
                print("Failed to create JSON with error: ", error.localizedDescription)
            }
            
        }.resume()
        
    }
    
    // получение изображения для PokedexCell item
    private func fetchImage(withUrlString urlString: String, completion: @escaping (UIImage) -> ()) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Failed to fetch image with error: ", error.localizedDescription)
                return
            }
            guard let data = data else { return }
            guard let image = UIImage(data: data) else { return }
            completion(image)
        }.resume()
    }
}
