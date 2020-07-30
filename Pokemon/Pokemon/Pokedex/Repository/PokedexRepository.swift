//
//  PokedexRepository.swift
//  Pokemon
//
//  Created by Brandon Gouws on 2020/07/30.
//  Copyright © 2020 DVT. All rights reserved.
//

import Foundation

class PokedexRepository: PokedexRepositorable {
    var httpService: httpServiceType?
    
    func getPokemonName(completion: @escaping ((Result<PokemonList, APIError>) -> Void)) {
        self.httpService = HttpService()
        httpService?.getPokemonList(completion: { result in
            switch result {
            case .success(let PokemonList):
                completion(.success(PokemonList))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    func getIndividualPokemon() {
        
    }
}
