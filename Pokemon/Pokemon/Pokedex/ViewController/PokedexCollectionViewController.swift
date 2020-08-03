//
//  PokedexCollectionViewController.swift
//  Pokemon
//
//  Created by Brandon Gouws on 2020/07/30.
//  Copyright © 2020 DVT. All rights reserved.
//

import UIKit

class PokedexCollectionViewController: UICollectionViewController {
    private lazy var viewModel = PokedexViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadPokedex()
        showLoadingIndicator()
        setUpNavigation()
    }
    
    private func loadPokedex() {
        viewModel.view = self
        viewModel.getPokemon()
    }
    
    private func setUpNavigation() {
        self.title = "pokedex.title".localized(in: "GlobalStrings")
        self.styleNavigationBar(searchbar: false)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getCount()
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellConstants.collectionViewCell, for: indexPath) as? CollectionViewCell else {
            return UICollectionViewCell()
        }
        let pokemon = viewModel.getCurrentPokemon(index: indexPath.row)
        cell.setUp(pokemon: pokemon)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == viewModel.getCount() - 1 {
            viewModel.loadNextPage()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigateToSingleView(index: indexPath.row)
    }
    
    private func navigateToSingleView(index: Int) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let singleViewViewController = storyBoard.instantiateViewController(withIdentifier: "SingleView") as! SingleViewViewController
        singleViewViewController.pokemonURL = viewModel.getSelectedPokemonURL(index: index)
        self.navigationController?.pushViewController(singleViewViewController, animated: true)
    }    
}

extension PokedexCollectionViewController: PokedexViewable {
    
    func displayError(error: APIError) {
        self.showActionAlert(title: "error.title".localized(in: "GlobalStrings"),
                             message: error.localizedDescription,
                             actions: [UIAlertAction(title: "error.cancel".localized(in: "GlobalStrings"),
                                                     style: .cancel)],
                             style: .alert)
    }
    
    func stopLoadingIndicator() {
        self.collectionView.reloadData()
        self.removeLoadingIndicator()
    }
}
