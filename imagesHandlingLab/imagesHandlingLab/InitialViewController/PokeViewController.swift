//
//  PokeViewController.swift
//  imagesHandlingLab
//
//  Created by albert coelho oliveira on 9/6/19.
//  Copyright © 2019 albert coelho oliveira. All rights reserved.
//

import UIKit

class PokeViewController: UIViewController {
    var pokeCards = [pokemons](){
        didSet{
            pokeTable.reloadData()
        }
    }
    
    @IBOutlet weak var seachPoke: UISearchBar!
    @IBOutlet weak var pokeTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        pokeTable.delegate = self
        pokeTable.dataSource = self
        seachPoke.delegate = self
        loadData()
    }
    private func loadData(){
        PokeCards.getPoke{ (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let pokes):
                    self.pokeCards = pokes
                }
            }
        }
    }
    var userSearchTerm: String? {
        didSet {
            self.pokeTable.reloadData()
        }
    }
    var filteredPokemon: [pokemons]  {
        guard let userSearchTerm = userSearchTerm else {
            return pokeCards
        }
        guard userSearchTerm != "" else {
            return pokeCards
        }
        
        return pokeCards.filter({ (pokeCards) -> Bool in
            pokeCards.name.lowercased().contains(userSearchTerm.lowercased())
        }
        )
    }
    
    
}
extension PokeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPokemon.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = pokeTable.dequeueReusableCell(withIdentifier: "pokeTableCell", for: indexPath) as! PokeTableViewCell 
        ImageHelper.shared.fetchImage(urlString:filteredPokemon[indexPath.row].imageUrl) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let image):
                    cell.pokeImage.image = image
                  
                }
            }
        }
        
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let pokemonVC = segue.destination as? detailPokemonViewController else {
            fatalError("Unexpected segue")
        }
        guard let selectedIndexPath = pokeTable.indexPathForSelectedRow
            else { fatalError("No row selected") }
        pokemonVC.myPokemon = filteredPokemon[selectedIndexPath.row]
    }

}
extension PokeViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.userSearchTerm = searchText
        
    }
    
}
