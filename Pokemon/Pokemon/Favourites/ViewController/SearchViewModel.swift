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
    public var repo: PokedexRepositorable?
    var pokemonList: [PokemonName] = []
    var filteredPokemon: [PokemonName] = []
    
    func getList(url: String = Endpoint.all.rawValue) {
        repo?.getPokemonName(endpoint: url, completion: { result in
            switch result {
            case .success(let pokemonList):
                self.pokemonList = pokemonList.results
                self.view?.populateData(pokemonList: pokemonList)
            case .failure(let error):
                self.view?.displayError(error: error)
            }
        })
    }
    
    func filterGuides(searchText: String, array: [PokemonName]) {
        filteredPokemon = self.pokemonList.filter({ (pokemonName: PokemonName) -> Bool in
            return pokemonName.name.lowercased().contains(searchText.lowercased())
        })
        if searchText == "" {
            self.view?.passFilteredPokemon(filteredList: self.pokemonList)
        } else {
            self.view?.passFilteredPokemon(filteredList: filteredPokemon)
        }
        
    }
}
