//
//  PokedexRepositorable.swift
//  Pokemon
//
//  Created by Brandon Gouws on 2020/07/30.
//  Copyright © 2020 DVT. All rights reserved.
//

import Foundation

protocol PokedexRepositorable {
    func getPokemonName(completion: @escaping((Result<PokemonList, APIError>) -> Void))
    func getIndividualPokemon()
}
