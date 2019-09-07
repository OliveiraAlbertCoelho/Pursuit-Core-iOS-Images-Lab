//
//  PokeModel.swift
//  imagesHandlingLab
//
//  Created by albert coelho oliveira on 9/6/19.
//  Copyright © 2019 albert coelho oliveira. All rights reserved.
//

import Foundation

struct PokeCards: Codable {
    let cards: [pokemons]
    static func getPoke(completionHandler: @escaping (Result<[pokemons],AppError>) -> () ) {
        
        let url = "https://api.pokemontcg.io/v1/cards"
        NetworkManager.shared.fetchData(urlString: url) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
                do {
                    let poke = try JSONDecoder().decode(PokeCards.self, from: data)
                    completionHandler(.success(poke.cards))
                } catch {
                    completionHandler(.failure(.badJSONError))                }
            }
        }
    }
}
struct pokemons: Codable{
    let name: String
    let imageUrl: String
    let imageUrlHiRes: String
    let types: [String]?
    let weaknesses: [weak]?
    let set: String?
    func getStringPoke(weak: [weak]?)-> String{
        if weak != nil{
            var weakness = ""
            for i in weak!{
                weakness += i.type.description + " "
            }
            return weakness
        }
    return "no Weakness"
    }
}
struct weak: Codable {
    let type: String
}
