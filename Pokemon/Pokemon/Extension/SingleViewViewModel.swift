//
//  SingleViewViewModel.swift
//  Pokemon
//
//  Created by Brandon Gouws on 2020/08/01.
//  Copyright © 2020 DVT. All rights reserved.
//

import Foundation

class SingleViewViewModel {
    public weak var view: SingleViewable?
    public var repo: PokedexRepositorable?
    var pokemon: Pokemon?
    
    func getSinglePokemon(url: String) {
        repo?.getIndividualPokemon(endpoint: url, method: .GET, completion: { result in
            switch result {
            case .success(let pokemon):
                self.pokemon = pokemon
                self.view?.dataReady()
            case .failure(let error):
                self.view?.display(error: error)
            }
        })
    }
    
    func getPokemon() -> Pokemon? {
        guard let pokemon = self.pokemon else {
            view?.display(error: .internalError)
            return nil
        }
        return pokemon
    }
}
