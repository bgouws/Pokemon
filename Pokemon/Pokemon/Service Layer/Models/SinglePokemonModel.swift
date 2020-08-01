//
//  IndividualPokemonModel.swift
//  Pokemon
//
//  Created by Brandon Gouws on 2020/07/30.
//  Copyright © 2020 DVT. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    let id: Int
    let name: String
    let base_experience: Int
    let height: Int
    let is_default: Bool
    let order: Int
    let weight: Int
    let sprites: Sprites
}

struct Sprites: Codable {
    let front_default: String
}
