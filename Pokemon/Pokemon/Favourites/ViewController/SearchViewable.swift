//
//  searchViewable.swift
//  Pokemon
//
//  Created by Brandon Gouws on 2020/07/31.
//  Copyright © 2020 DVT. All rights reserved.
//

import Foundation

protocol SearchViewable: class {
    func displayError(error: APIError)
    func stopLoadingIndicator()
    func dataReady() 
}
