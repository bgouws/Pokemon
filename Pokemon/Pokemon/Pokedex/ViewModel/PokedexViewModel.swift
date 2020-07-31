//
//  PokedexViewModel.swift
//  Pokemon
//
//  Created by Brandon Gouws on 2020/07/30.
//  Copyright © 2020 DVT. All rights reserved.
//

import Foundation

class PokedexViewModel {
    public weak var view: PokedexViewable?
    public var repo: PokedexRepositorable?
    var singlePokemon = [IndividualPokemon]()

    func getPokemonList(url: String = baseURL) {
        repo?.getPokemonName(endpoint: url, completion: { result in
            switch result {
            case .success(let pokemonList):
                self.getSinglePokemonList(pokemonList: pokemonList)
                self.view?.populateData(pokemonList: pokemonList)
            case .failure(let error):
                self.view?.displayError(error: error)
            }
        })
    }
    
    private func getSinglePokemonList(pokemonList: PokemonList) {
        let group = DispatchGroup()
        for pokemon in 0...pokemonList.results.count - 1 {
            group.enter()
            print("####")
            print(pokemonList.results[pokemon].url)
            print("####")
            repo?.getIndividualPokemon(endpoint: pokemonList.results[pokemon].url, method: .GET, completion: { result in
                switch result {
                case .success(let singlePokemon):
                    self.singlePokemon.append(singlePokemon)
                    group.leave()
                    print("Single List: \(self.singlePokemon)")
                case .failure(let error):
                    self.view?.displayError(error: error)
                }
            })
        }
        group.notify(queue: DispatchQueue.main) {
            self.view?.populateSinglePokemon(singlePokemon: self.singlePokemon)
        }
    }
    
//    func getSinglePokemon(url: String) {
//        repo?.getIndividualPokemon(endpoint: url, method: .GET, completion: { result in
//            switch result {
//            case .success(let singlePokemon):
//                self.view?.populateSinglePokemon(singlePokemon: singlePokemon)
//            case .failure(let error):
//                self.view?.displayError(error: error)
//            }
//        })
//    }
}
