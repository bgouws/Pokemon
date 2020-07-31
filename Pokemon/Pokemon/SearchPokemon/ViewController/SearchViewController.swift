//
//  SearchViewController.swift
//  Pokemon
//
//  Created by Brandon Gouws on 2020/07/31.
//  Copyright © 2020 DVT. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    let viewModel = searchViewModel()
    let tableView = UITableView()
    var pokemonList = [PokemonName]()
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSearchList()
        setUpNavigationBar()
        createTableView()
    }
    
    func loadSearchList() {
        viewModel.view = self
        viewModel.repo = PokedexRepository()
        viewModel.getList()
    }
    
    func createTableView() {
        self.view.addSubview(self.tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = true
    }
    
    func setUpNavigationBar() {
        self.title = "Seach Pokemon"
        self.styleNavigationBar(searchbar: true)
        self.navigationItem.searchController?.searchBar.delegate = self
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.viewModel.filterGuides(searchText: searchText, array: self.pokemonList)
        if searchText == "" {
            tableView.isHidden = true
        } else {
            tableView.isHidden = false
        }
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.viewModel.filterGuides(searchText: "", array: self.pokemonList)
        tableView.isHidden = true
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if searchBar.text == "" {
            tableView.isHidden = true
        }
    }
}

extension SearchViewController: SearchViewable {
    func passFilteredPokemon(filteredList: [PokemonName]) {
        self.pokemonList = filteredList
        self.tableView.reloadData()
    }
    
    func populateData(pokemonList: PokemonList) {
        self.pokemonList = pokemonList.results
    }
    
    func displayError(error: APIError) {
        self.showActionAlert(title: "Error",
        message: error.localizedDescription,
        actions: [UIAlertAction(title: "Cancel",
                                style: .cancel)],
            style: .alert)
    }
    
    func stopLoadingIndicator() {
        //
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pokemonList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = self.pokemonList[indexPath.row].name
        return cell!
    }
    
    
}
