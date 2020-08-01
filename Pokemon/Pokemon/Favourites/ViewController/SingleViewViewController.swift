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
        if searching == nil {
            populateFields()
        } else {
            getPokemon()
        }
        
    }
    
    func getPokemon() {
        viewModel.view = self
        viewModel.repo = PokedexRepository()
        guard let url = pokemonURL else { return }
        viewModel.getSinglePokemon(url: url)
    }
    
    private func getSelectedPokemon() {
        self.singlePokemon = viewModel.getPokemon()
        populateFields()
    }
    
    
    
    func populateFields() {
        DispatchQueue.main.async {
            guard let singlePokemon = self.singlePokemon else {return}
            guard let url = URL(string: singlePokemon.sprites.front_default) else { return }
            self.imgView.downloadImage(from: url)
            self.title = singlePokemon.name
            self.lblName.text = "Name: \(singlePokemon.name)"
            self.lblBaseExperience.text = "Base Experience: \(singlePokemon.base_experience)"
            self.lblHeight.text = "Height: \(singlePokemon.height)"
            self.lblWeight.text = "Weight: \(singlePokemon.weight)"
        }
    }
}

extension SingleViewViewController: SingleViewable {
    func stopLoadingIndicator() {
        //
    }
    
    func dataReady() {
        self.getSelectedPokemon()
    }
    
    func display(error: APIError) {
        self.showActionAlert(title: "Error",
                             message: error.localizedDescription,
                             actions: [UIAlertAction(title: "Cancel",
                                                     style: .cancel)],
                             style: .alert)
    }
    
}
