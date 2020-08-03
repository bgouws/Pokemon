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
    var pokemonURL: String?
    var searching: Bool?
    private lazy var viewModel = SingleViewViewModel()
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblBaseExperience: UILabel!
    @IBOutlet weak var lblHeight: UILabel!
    @IBOutlet weak var lblWeight: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.searching != nil {
            getPokemon()
        } else {
            populateFields()
        }
    }
    
    func getPokemon() {
        viewModel.view = self
        viewModel.repo = Repository()
        guard let url = pokemonURL else { return }
        viewModel.getSinglePokemon(url: url)
    }
    
    func populateFields() {
        styleLabels()
        guard let singlePokemon = self.singlePokemon else {return}
        guard let url = URL(string: singlePokemon.sprites.front_default) else { return }
        self.title = singlePokemon.name
        self.lblName.text = "Name: \(singlePokemon.name)"
        self.lblBaseExperience.text = "Base Experience: \(singlePokemon.base_experience)"
        self.lblHeight.text = "Height: \(singlePokemon.height)"
        self.lblWeight.text = "Weight: \(singlePokemon.weight)"
        self.imgView.downloadImage(from: url)
    }
    
    
    func styleLabels() {
        lblName.styleLabels()
        lblBaseExperience.styleLabels()
        lblHeight.styleLabels()
        lblWeight.styleLabels()
    }
}

extension SingleViewViewController: SingleViewable {
    func populateData(pokemon: Pokemon) {
        self.singlePokemon = pokemon
        DispatchQueue.main.async {
            self.populateFields()
        }
    }
    
    func display(error: APIError) {
        self.showActionAlert(title: "Error",
                             message: error.localizedDescription,
                             actions: [UIAlertAction(title: "Cancel",
                                                     style: .cancel)],
                             style: .alert)
    }
    
}
