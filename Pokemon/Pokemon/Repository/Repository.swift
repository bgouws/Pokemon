//
//  PokedexRepository.swift
//  Pokemon
//
//  Created by Brandon Gouws on 2020/07/30.
//  Copyright © 2020 DVT. All rights reserved.
//

import Foundation

class Repository: Repositorable {
    var httpService: httpServiceType?
    
    func getPokemon(endpoint: String, completion: @escaping ((Result<PokemonResponse, APIError>) -> Void)) {
        self.httpService = HttpService()
        httpService?.getPokemon(endpoint: endpoint, completion: { result in
            switch result {
            case .success(let PokemonList):
                completion(.success(PokemonList))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    func getSinglePokemon(endpoint: String, method: Method, completion: @escaping((Result<Pokemon, APIError>) -> Void)) {
        self.httpService = HttpService()
        httpService?.getSinglePokemon(endpoint: endpoint, method: .GET, completion: { result in
            switch result {
            case .success(let singlePokemon):
                completion(.success(singlePokemon))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
}
