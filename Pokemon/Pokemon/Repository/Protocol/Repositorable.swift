//
//  PokedexRepositorable.swift
//  Pokemon
//
//  Created by Brandon Gouws on 2020/07/30.
//  Copyright © 2020 DVT. All rights reserved.
//

import Foundation

protocol Repositorable {
    func getPokemonResponse(endpoint: String, completion: @escaping((Result<PokemonResponse, APIError>) -> Void))
    func getSinglePokemon(endpoint: String, completion: @escaping((Result<Pokemon, APIError>) -> Void))
}
