//
//  PokedexViewable.swift
//  Pokemon
//
//  Created by Brandon Gouws on 2020/07/30.
//  Copyright © 2020 DVT. All rights reserved.
//

import Foundation

protocol PokedexViewable: class {
    func populateData(pokemonList: PokemonResponse)
    func displayError(error: APIError)
    func stopLoadingIndicator()
    func populateSinglePokemon(singlePokemon: [Pokemon])
}
