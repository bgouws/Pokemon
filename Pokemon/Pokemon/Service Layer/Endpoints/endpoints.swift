//
//  endpoints.swift
//  Pokemon
//
//  Created by Brandon Gouws on 2020/07/29.
//  Copyright © 2020 DVT. All rights reserved.
//

import Foundation

let baseURL = "https://pokeapi.co/api/v2/pokemon"

enum Endpoint: String {
    case name = "OtherEndPoints"
    case basic = "?limit=20"
}

enum Method: String {
    case GET
}
