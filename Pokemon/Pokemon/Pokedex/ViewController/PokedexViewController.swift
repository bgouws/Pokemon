//
//  PokedexViewController.swift
//  Pokemon
//
//  Created by Brandon Gouws on 2020/07/30.
//  Copyright © 2020 DVT. All rights reserved.
//

import UIKit

class PokedexViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let viewModel = PokedexViewModel()
        viewModel.view = self
        viewModel.repo = PokedexRepository()
        viewModel.getPokemonList()
    }
}
extension PokedexViewController: PokedexViewable {
    func populateSinglePokemon(singlePokemon: [IndividualPokemon]) {
        //
    }
    
    func populateData(pokemonList: PokemonList) {
        print(pokemonList)
        print("We Did It")
    }
    
    func displayError(error: APIError) {
        showActionAlert(title: "Error",
                        message: error.localizedDescription,
                        actions: [UIAlertAction(title: "Cancel",
                                                style: .cancel)],
                        style: .alert)
    }
    
    func stopLoadingIndicator() {
        // MARK: Handle Loading Here
    }
}
