//
//  SearchViewModelable.swift
//  Pokemon
//
//  Created by Brandon Gouws on 2020/08/01.
//  Copyright © 2020 DVT. All rights reserved.
//

import Foundation

protocol SearchViewmodelable {
    func getAllPokemon()
    func filterPokemon(searchText: String)
}
