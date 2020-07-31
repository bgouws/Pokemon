//
//  PokemonModel.swift
//  Pokemon
//
//  Created by Brandon Gouws on 2020/07/29.
//  Copyright © 2020 DVT. All rights reserved.
//

import Foundation

struct PokemonList: Codable {
    let count: Int
    let next: String
    let previous: String?
    let results: [PokemonName]
}

struct PokemonName: Codable {
    let name: String
    let url: String
}
