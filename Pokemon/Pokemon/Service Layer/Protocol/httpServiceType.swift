//
//  Repositorable.swift
//  Pokemon
//
//  Created by Brandon Gouws on 2020/07/29.
//  Copyright © 2020 DVT. All rights reserved.
//

import Foundation

enum APIError: Error {
    case internalError
    case serverError
    case parsingError
}

protocol httpServiceType {
    func getPokemonList(endpoint: String, completion: @escaping((Result<PokemonResponse, APIError>) -> Void))
    func getSingle(endpoint: String, method: Method, completion: @escaping((Result<Pokemon, APIError>) -> Void))
}
