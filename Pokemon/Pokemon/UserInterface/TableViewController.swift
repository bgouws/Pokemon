//
//  TableViewController.swift
//  Pokemon
//
//  Created by Brandon Gouws on 2020/07/29.
//  Copyright © 2020 DVT. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    let fakeData = ["Brandon", "Megan", "James", "John", "Matt", "Alice", "Lucy"]
    var data = [PokemonIndividual]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = data[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(data[indexPath.row])
        let pokemanFactory = Repository()
        pokemanFactory.getSingle(endPoint: data[indexPath.row].url, method: .GET) { result in
            switch result {
            case .success(let selected):
                DispatchQueue.main.async {
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let singlePokemonViewController = storyBoard.instantiateViewController(withIdentifier: "SinglePokemonView") as! SinglePokemonViewController
                    singlePokemonViewController.data = selected
                    self.navigationController?.pushViewController(singlePokemonViewController, animated: true)
                }
            case .failure(let error):
                print(error)
            }
        }
        print(indexPath.row)
    }
}
