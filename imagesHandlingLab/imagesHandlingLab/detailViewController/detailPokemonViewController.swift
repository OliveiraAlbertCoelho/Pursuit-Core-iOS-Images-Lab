//
//  detailPokemonViewController.swift
//  imagesHandlingLab
//
//  Created by albert coelho oliveira on 9/6/19.
//  Copyright © 2019 albert coelho oliveira. All rights reserved.
//

import UIKit

class detailPokemonViewController: UIViewController {
    
    @IBOutlet weak var pokeImage: UIImageView!
    @IBOutlet weak var pokeName: UILabel!
    @IBOutlet weak var pokeWeak: UILabel!
    @IBOutlet weak var pokeTypes: UILabel!
    @IBOutlet weak var pokeSet: UILabel!
    
    var myPokemon: pokemons?
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUp()
        getImage()
    }
    func loadUp(){
        if let name = myPokemon?.name{
            pokeName.text = "Name: \(name)"}
        if let type = myPokemon?.types?.joined(separator: ","){
            pokeTypes.text = "Type: \(type)"} else{
            pokeTypes.text = "No type"
        }
        if let weakness = myPokemon?.getStringPoke(weak: myPokemon?.weaknesses){
            pokeWeak.text = "Weakness: \(weakness)"} else {
            pokeWeak.text = "No Weakness"
        }
        if let set =  myPokemon?.set {
            pokeSet.text = "Set: \(set)"}else {
            pokeSet.text = "No Set"
        }
    }
    
    func getImage(){
        ImageHelper.shared.fetchImage(urlString:myPokemon!.imageUrlHiRes) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let image):
                    self.pokeImage.image = image
                }
            }
        }
    }
    
    
}
