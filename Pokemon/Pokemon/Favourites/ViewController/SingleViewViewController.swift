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
    
    @IBOutlet private weak var imgView: UIImageView!
    @IBOutlet private weak var lblName: UILabel!
    @IBOutlet private weak var lblBaseExperience: UILabel!
    @IBOutlet private weak var lblHeight: UILabel!
    @IBOutlet private weak var lblWeight: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoadingIndicator()
        if self.searching != nil {
            getPokemon()
        } else {
            removeLoadingIndicator()
            populateFields()
        }
    }
    
    private func getPokemon() {
        viewModel.view = self
        guard let url = pokemonURL else { return }
        viewModel.getSinglePokemon(url: url)
    }
    
    private func populateFields() {
        styleLabels()
        guard let singlePokemon = self.singlePokemon else {return}
        guard let url = URL(string: singlePokemon.sprites.front_default) else { return }
        self.title = singlePokemon.name
        self.lblName.text = "\("single.name".localized(in: "GlobalStrings"))\(singlePokemon.name)"
        self.lblBaseExperience.text = "\("single.experience".localized(in: "GlobalStrings"))\(singlePokemon.base_experience)"
        self.lblHeight.text = "\("single.height".localized(in: "GlobalStrings"))\(singlePokemon.height)"
        self.lblWeight.text = "\("single.weight".localized(in: "GlobalStrings"))\(singlePokemon.weight)"
        self.imgView.downloadImage(from: url)
    }
    
    
    private func styleLabels() {
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
            self.removeLoadingIndicator()
        }
    }
    
    func display(error: APIError) {
        self.showActionAlert(title: "error.title".localized(in: "GlobalStrings"),
                             message: error.localizedDescription,
                             actions: [UIAlertAction(title: "error.cancel".localized(in: "GlobalStrings"),
                                                     style: .cancel)],
                             style: .alert)
    }
    
}
