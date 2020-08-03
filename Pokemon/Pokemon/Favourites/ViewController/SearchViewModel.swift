//
//  SearchViewModel.swift
//  Pokemon
//
//  Created by Brandon Gouws on 2020/07/31.
//  Copyright © 2020 DVT. All rights reserved.
//

import Foundation

class searchViewModel: SearchViewmodelable {
    public weak var view: SearchViewable?
    public var repo: Repositorable?
    private var pokemonList: [PokemonName] = []
    private var filteredPokemon: [PokemonName] = []
    
    init() {
        self.repo = Repository()
    }
    
    func getAllPokemon() {
        repo?.getPokemonResponse(endpoint: Endpoint.allPokemon.rawValue, completion: { result in
            switch result {
            case .success(let pokemon):
                self.pokemonList = pokemon.results
                self.view?.stopLoadingIndicator()
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
            self.view?.dataReady()
        } else {
            self.view?.dataReady()
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
