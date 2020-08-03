//
//  UILabelExtension.swift
//  Pokemon
//
//  Created by Brandon Gouws on 2020/08/03.
//  Copyright © 2020 DVT. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    func styleLabels() {
        layer.borderColor = UIColor.systemRed.cgColor
        layer.borderWidth = 3
        layer.cornerRadius = 8.0
        clipsToBounds = true
    }
}


