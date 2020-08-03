//
//  SearchViewModel.swift
//  Pokemon
//
//  Created by Brandon Gouws on 2020/07/31.
//  Copyright © 2020 DVT. All rights reserved.
//

import Foundation

class searchViewModel {
    public weak var view: SearchViewable?
    public var repo: Repositorable?
    var pokemonList: [PokemonName] = []
    var filteredPokemon: [PokemonName] = []
    
    func getAllPokemon(url: String = Endpoint.all.rawValue) {
        repo?.getPokemon(endpoint: url, completion: { result in
            switch result {
            case .success(let pokemon):
                self.pokemonList = pokemon.results
            case .failure(let error):
                self.view?.displayError(error: error)
            }
        })
    }
    
    func filterPokemon(searchText: String) {
        filteredPokemon = self.pokemonList.filter({ (pokemonName: PokemonName) -> Bool in
            return pokemonName.name.lowercased().contains(searchText.lowercased())
        })
        if searchText == "" {
            self.view?.stopLoadingIndicator()
        } else {
            self.view?.stopLoadingIndicator()
        }
        
    }
    
    func getCount() -> Int {
        return self.filteredPokemon.count
    }
    
    func getSelectedPokemonURL(index: Int) -> String {
        return self.filteredPokemon[index].url
    }
    
    func getPokemonName(index: Int) -> String {
        return self.filteredPokemon[index].name
    }
}
