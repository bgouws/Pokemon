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
        setUpNavigation()
    }
    
    func loadPokedex() {
        viewModel.view = self
        viewModel.repo = Repository()
        viewModel.getPokemon()
    }
    
    func setUpNavigation() {
        self.title = "Pokedex"
        self.styleNavigationBar(searchbar: false)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getCount()
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Pokemon", for: indexPath) as? CollectionViewCell else {
            return UICollectionViewCell()
        }
        let pokemon = viewModel.nextSinglePokemon(index: indexPath.row)
        cell.setUp(pokemon: pokemon)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == viewModel.getCount() - 3 {
            viewModel.loadNextPage()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedPokemon = viewModel.getCurrentPokemon(index: indexPath.row)
        navigateToSingleView(selectedPokemon: selectedPokemon)
    }
    
    private func navigateToSingleView(selectedPokemon: Pokemon) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let singleViewViewController = storyBoard.instantiateViewController(withIdentifier: "SingleView") as! SingleViewViewController
        singleViewViewController.singlePokemon = selectedPokemon
        self.navigationController?.pushViewController(singleViewViewController, animated: true)
    }
    
}

extension PokedexCollectionViewController: PokedexViewable {
    
    func displayError(error: APIError) {
        self.showActionAlert(title: "Error",
                             message: error.localizedDescription,
                             actions: [UIAlertAction(title: "Cancel",
                                                     style: .cancel)],
                             style: .alert)
    }
    
    func stopLoadingIndicator() {
        self.collectionView.reloadData()
    }
}
