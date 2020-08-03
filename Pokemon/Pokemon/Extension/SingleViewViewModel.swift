//
//  SingleViewViewModel.swift
//  Pokemon
//
//  Created by Brandon Gouws on 2020/08/01.
//  Copyright © 2020 DVT. All rights reserved.
//

import Foundation

class SingleViewViewModel: SingleViewModelable {
    public weak var view: SingleViewable?
    public var repo: Repositorable?
    private var pokemon: Pokemon?
    
    init() {
        self.repo = Repository()
    }
    
    func getSinglePokemon(url: String) {
        repo?.getSinglePokemon(endpoint: url, completion: { result in
            switch result {
            case .success(let pokemon):
                self.pokemon = pokemon
                self.view?.stopLoadingIndicator()
            case .failure(let error):
                self.view?.display(error: error)
            }
        })
    }
    
    func getSelectedPokemon() -> Pokemon? {
        guard let pokemon = self.pokemon else { return nil }
        return pokemon
    }
}
