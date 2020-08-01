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
    
    func getPokemonName(endpoint: String, completion: @escaping ((Result<PokemonResponse, APIError>) -> Void)) {
        self.httpService = HttpService()
        httpService?.getPokemonList(endpoint: endpoint, completion: { result in
            switch result {
            case .success(let PokemonList):
                completion(.success(PokemonList))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    func getIndividualPokemon(endpoint: String, method: Method, completion: @escaping((Result<Pokemon, APIError>) -> Void)) {
        self.httpService = HttpService()
        httpService?.getSingle(endpoint: endpoint, method: .GET, completion: { result in
            switch result {
            case .success(let singlePokemon):
                completion(.success(singlePokemon))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
}
