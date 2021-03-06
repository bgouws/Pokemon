//
//  Repository.swift
//  Pokemon
//
//  Created by Brandon Gouws on 2020/07/29.
//  Copyright © 2020 DVT. All rights reserved.
//

import Foundation

class HttpService: httpServiceType {
    func getPokemon(endpoint: String, completion: @escaping ((Result<PokemonResponse, APIError>) -> Void)) {
        request(endpoint: endpoint, method: .GET, completion: completion)
    }
    
    func getSinglePokemon(endpoint: String, method: Method, completion: @escaping((Result<Pokemon, APIError>) -> Void)) {
        request(endpoint: endpoint, method: .GET, completion: completion)
    }
    
    private func request<T: Codable>(endpoint: String, method: Method, completion: @escaping((Result<T, APIError>) -> Void)) {
        guard let url = URL(string: endpoint) else {
            completion(.failure(.internalError))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "\(method)"
        request.allHTTPHeaderFields = ["Content-Type": "application/json"]
        call(with: request, completion: completion)
    }
    
    private func call<T: Codable>(with request: URLRequest, completion: @escaping((Result<T, APIError>) -> Void)) {
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                completion(.failure(.serverError))
                return
            }
            do {
                guard let data = data else {
                    completion(.failure(.serverError))
                    return
                }
                let object = try JSONDecoder().decode(T.self, from: data)
                completion(Result.success(object))
            } catch {
                completion(Result.failure(.parsingError))
            }
        }
        dataTask.resume()
    }
}
