//
//  PokedexCollectionViewController.swift
//  Pokemon
//
//  Created by Brandon Gouws on 2020/07/30.
//  Copyright © 2020 DVT. All rights reserved.
//

import UIKit

class PokedexCollectionViewController: UICollectionViewController {
    private lazy var viewModel = PokedexViewModel()
    var pokemonList: [PokemonName]?
    var singlePokemonList: [Pokemon]?
    var nextPage: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPokedex()
        setUpNavigation()
    }
    
    func loadPokedex() {
        viewModel.view = self
        viewModel.repo = Repository()
        viewModel.getPokemon()
    }
    
    func setUpNavigation() {
        self.title = "Pokedex"
        self.styleNavigationBar(searchbar: false)
    }
    
    func loadNextPage(url: String) {  
        viewModel.getPokemon(url: url)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let singlePokemonList = self.singlePokemonList else { return 0 }
        return singlePokemonList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Pokemon", for: indexPath) as? CollectionViewCell else {
            return UICollectionViewCell()
        }
        if let singlePokemonList = self.singlePokemonList {
            cell.setUp(pokemon: singlePokemonList[indexPath.row])
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let singlePokemonList = self.singlePokemonList else { return }
        if indexPath.row == singlePokemonList.count - 1 {
            guard let nextPage = self.nextPage else { return }
            self.loadNextPage(url: nextPage)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let singlePokemonList = self.singlePokemonList else { return } // Move to seperate function 
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let singleViewViewController = storyBoard.instantiateViewController(withIdentifier: "SingleView") as! SingleViewViewController
        singleViewViewController.singlePokemon = singlePokemonList[indexPath.row]
        self.navigationController?.pushViewController(singleViewViewController, animated: true)
    }
}

extension PokedexCollectionViewController: PokedexViewable {
    func populateSinglePokemon(singlePokemon: [Pokemon]) {
        self.singlePokemonList = singlePokemon
        self.collectionView.reloadData()
    }
    
    func populateData(pokemonList: PokemonResponse) {
        self.pokemonList = pokemonList.results
        self.nextPage = pokemonList.next
    }
    
    func displayError(error: APIError) {
        self.showActionAlert(title: "Error",
                             message: error.localizedDescription,
                             actions: [UIAlertAction(title: "Cancel",
                                                     style: .cancel)],
                             style: .alert)
    }
    
    func stopLoadingIndicator() {
        
    }
}
