//
//  CollectionViewCell.swift
//  Pokemon
//
//  Created by Brandon Gouws on 2020/07/30.
//  Copyright © 2020 DVT. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    func setUp(pokemon: IndividualPokemon) {
        self.lblName.text = pokemon.name
        guard let urlImage = URL(string: pokemon.sprites.front_default) else { return }
        self.downloadImage(from: urlImage)
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() { [weak self] in
                self?.imgView.image = UIImage(data: data)
            }
        }
    }
}
