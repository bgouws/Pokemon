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
    func setUp(pokemon: Pokemon) {
        self.lblName.text = pokemon.name
        guard let urlImage = URL(string: pokemon.sprites.front_default) else { return }
        imgView.image = nil
        imgView.downloadImage(from: urlImage)
        styleCell()
    }
    
    func styleCell() {
        self.stylePokemonCell()
        imgView.stylePokemonImage()
    }
}
