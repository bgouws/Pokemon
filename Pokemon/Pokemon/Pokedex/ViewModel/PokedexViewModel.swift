//
//  PokedexViewModel.swift
//  Pokemon
//
//  Created by Brandon Gouws on 2020/07/30.
//  Copyright © 2020 DVT. All rights reserved.
//

import Foundation

class PokedexViewModel: PokedexViewModelable {
    public weak var view: PokedexViewable?
    public var repo: Repositorable?
    private var pokemonNames = [PokemonName]()
    private var singlePokemon = [Pokemon]()
    private var nextPage: String?
    
    init() {
        self.repo = Repository()
    }

    func getPokemon(url: String = Endpoint.page.rawValue) {
        repo?.getPokemonResponse(endpoint: url, completion: { result in
            switch result {
            case .success(let pokemonResponse):
                self.pokemonNames.append(contentsOf: pokemonResponse.results)
                self.getSinglePokemon(pokemon: pokemonResponse.results)
                self.nextPage = pokemonResponse.next
            case .failure(let error):
                self.view?.displayError(error: error)
            }
        })
    }
    
    func getSinglePokemon(pokemon: [PokemonName]) {
        let group = DispatchGroup()
        for index in 0..<pokemon.count {
            group.enter()
            repo?.getSinglePokemon(endpoint: pokemon[index].url, completion: { result in
                switch result {
                case .success(let singlePokemon):
                    self.singlePokemon.append(singlePokemon)
                    group.leave()
                case .failure(let error):
                    self.view?.displayError(error: error)
                }
            })
        }
        group.notify(queue: DispatchQueue.main) {
            self.sortPokemon(pokemon: self.singlePokemon)
            self.view?.stopLoadingIndicator()
        }
    }
    
    private func sortPokemon(pokemon: [Pokemon]) {
        self.singlePokemon = pokemon.sorted(by: {$0.id < $1.id})
    }
    
    func nextSinglePokemon(index: Int) -> Pokemon {
        return self.singlePokemon[index]
    }
    
    func getCount() -> Int {
        return self.singlePokemon.count
    }
    
    func getCurrentPokemon(index: Int) -> Pokemon {
        return self.singlePokemon[index]
    }
    
    func loadNextPage() {
        guard let url = self.nextPage else { return }
        getPokemon(url: url)
    }
    
    func getSelectedPokemonURL(index: Int) -> String? {
        return pokemonNames[index].url
    }
}
