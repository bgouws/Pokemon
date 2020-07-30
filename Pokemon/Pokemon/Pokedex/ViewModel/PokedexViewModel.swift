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

    func getPokemonList() {
        repo?.getPokemonName(completion: { result in
            switch result {
            case .success(let pokemonList):
                self.view?.populateData(pokemonList: pokemonList)
            case .failure(let error):
                self.view?.displayError(error: error)
            }
        })
    }
}
