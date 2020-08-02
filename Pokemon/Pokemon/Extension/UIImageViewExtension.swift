//
//  UIImageViewExtension.swift
//  Pokemon
//
//  Created by Brandon Gouws on 2020/07/31.
//  Copyright © 2020 DVT. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func downloadImage(from url: URL) {
        self.image = UIImage(named: "imageLoading")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                self.image = UIImage(data: data)
            }
        }
    }
    
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func stylePokemonImage() {
        backgroundColor = .white
        layer.cornerRadius = 8.0
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 0.4
        clipsToBounds = true
    }
}
