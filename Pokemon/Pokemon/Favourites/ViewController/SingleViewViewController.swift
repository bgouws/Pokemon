//
//  SingleViewViewController.swift
//  Pokemon
//
//  Created by Brandon Gouws on 2020/07/31.
//  Copyright © 2020 DVT. All rights reserved.
//

import UIKit

class SingleViewViewController: UIViewController {
    var singlePokemon: Pokemon?
    var searching: Bool?
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblBaseExperience: UILabel!
    @IBOutlet weak var lblHeight: UILabel!
    @IBOutlet weak var lblWeight: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateFields()
    }
    
    func populateFields() {
        guard let singlePokemon = self.singlePokemon else {return}
        guard let url = URL(string: singlePokemon.sprites.front_default) else { return }
        imgView.downloadImage(from: url)
        self.title = singlePokemon.name
        lblName.text = "Name: \(singlePokemon.name)"
        lblBaseExperience.text = "Base Experience: \(singlePokemon.base_experience)"
        lblHeight.text = "Height: \(singlePokemon.height)"
        lblWeight.text = "Weight: \(singlePokemon.weight)"
    }
}
