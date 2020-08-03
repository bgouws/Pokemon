//
//  SingleViewable.swift
//  Pokemon
//
//  Created by Brandon Gouws on 2020/08/01.
//  Copyright © 2020 DVT. All rights reserved.
//

import Foundation

protocol SingleViewable: class {
    func stopLoadingIndicator()
    func display(error: APIError)
}
