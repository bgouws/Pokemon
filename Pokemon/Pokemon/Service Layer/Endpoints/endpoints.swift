//
//  endpoints.swift
//  Pokemon
//
//  Created by Brandon Gouws on 2020/07/29.
//  Copyright © 2020 DVT. All rights reserved.
//

import Foundation

enum Endpoint: String {
    case allPokemon = "https://pokeapi.co/api/v2/pokemon?limit=964"
    case page = "https://pokeapi.co/api/v2/pokemon?offset=0&limit=20"
}

enum Method: String {
    case GET
}
