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
    var singlePokemon = [Pokemon]()
    var nextPage: String?

    func getPokemon(url: String = baseURL) {
        repo?.getPokemon(endpoint: url, completion: { result in
            switch result {
            case .success(let pokemon):
                self.getSinglePokemon(pokemon: pokemon.results)
                self.nextPage = pokemon.next
            case .failure(let error):
                self.view?.displayError(error: error)
            }
        })
    }
    
    func getSinglePokemon(pokemon: [PokemonName]) {
        let group = DispatchGroup()
        for index in 0...pokemon.count - 1 {
            group.enter()
            repo?.getSinglePokemon(endpoint: pokemon[index].url, method: .GET, completion: { result in
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
            self.view?.stopLoadingIndicator()
        }
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
}
