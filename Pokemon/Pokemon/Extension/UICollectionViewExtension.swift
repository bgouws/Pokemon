//
//  UICollectionViewExtension.swift
//  Pokemon
//
//  Created by Brandon Gouws on 2020/08/01.
//  Copyright © 2020 DVT. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionViewCell {
    func stylePokemonCell() {
        layer.borderWidth = 2
        backgroundColor = .lightGray
        layer.borderColor = UIColor.black.cgColor
        layer.cornerRadius = 8.0
        clipsToBounds = true
    }
}
