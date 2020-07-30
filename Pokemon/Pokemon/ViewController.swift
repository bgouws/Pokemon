//
//  ViewController.swift
//  Pokemon
//
//  Created by Brandon Gouws on 2020/07/29.
//  Copyright © 2020 DVT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var btnWelcome: UIButton!
    var mainData = [PokemonIndividual]()
    override func viewDidLoad() {
        super.viewDidLoad()
        let pokemanFactory = Repository()
        pokemanFactory.getPokemonList { result in
            switch result {
            case .success(let pokeman):
                for pokemon in pokeman.results {
                    print(pokemon.name)
                    self.mainData = pokeman.results
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
        self.view.backgroundColor = .yellow
    }
    @IBAction func btnWelcomeTapped(_ sender: Any) {
        toCollectionView()
    }
    
    private func toTableView() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let tableViewController = storyBoard.instantiateViewController(withIdentifier: "TableViewController") as! TableViewController
        tableViewController.data = self.mainData
        self.navigationController?.pushViewController(tableViewController, animated: true)
    }
    private func toCollectionView() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let pokemonCollection = storyBoard.instantiateViewController(withIdentifier: "PokemonCollectionViewController") as! PokemonCollectionViewController
        pokemonCollection.data = self.mainData
        self.navigationController?.pushViewController(pokemonCollection, animated: true)
    }
}
