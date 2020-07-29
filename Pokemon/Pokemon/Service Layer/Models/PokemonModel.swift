//
//  PokemonModel.swift
//  Pokemon
//
//  Created by Brandon Gouws on 2020/07/29.
//  Copyright © 2020 DVT. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    let count: Int
    let next: String
    let previous: String?
    let results: [PokemonIndividual]
}

struct PokemonIndividual: Codable {
    let name: String
    let url: String
}

struct ActualPokemon: Codable {
    let id: Int
    let name: String
    let sprites: [Sprites]
}

struct Sprites: Codable {
    let front_female: String
}
