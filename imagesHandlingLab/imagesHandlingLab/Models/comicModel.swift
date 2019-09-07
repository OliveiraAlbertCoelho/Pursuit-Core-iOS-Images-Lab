//
//  comicModel.swift
//  imagesHandlingLab
//
//  Created by albert coelho oliveira on 9/6/19.
//  Copyright © 2019 albert coelho oliveira. All rights reserved.
//

import Foundation

struct Comic: Codable {
    let num: Int
    let img: String
   
  
    static func getComic(userNum: Int?,completionHandler: @escaping (Result<Comic,AppError>) -> () ) {
        
        var url = "https://xkcd.com/info.0.json"
        if let number = userNum{
            url = "https://xkcd.com/\(number)/info.0.json"
        }
        NetworkManager.shared.fetchData(urlString: url) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
                do {
                    let comicBook = try JSONDecoder().decode(Comic.self, from: data)
                    completionHandler(.success(comicBook))
                } catch {
                    completionHandler(.failure(.badJSONError))                }
            }
        }
    }
}
