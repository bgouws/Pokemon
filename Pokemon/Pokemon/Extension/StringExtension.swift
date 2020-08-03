//
//  StringExtension.swift
//  Pokemon
//
//  Created by Brandon Gouws on 2020/08/03.
//  Copyright © 2020 DVT. All rights reserved.
//

import Foundation

extension String {
    func localized(in table: String, bundle: Bundle = Bundle.main) -> String {
        return NSLocalizedString(self, tableName: table, bundle: bundle, value: "", comment: "")
    }
}


