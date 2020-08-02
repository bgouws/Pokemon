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
        
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSearchList()
        setUpNavigationBar()
        setUpTableView()
    }
    
    func loadSearchList() {
        viewModel.view = self
        viewModel.repo = Repository()
        viewModel.getAllPokemon()
    }
    
    func setUpTableView() {
        self.view.addSubview(self.tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
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
    
    private func moveToSingleView(index: Int) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let singleViewViewController = storyBoard.instantiateViewController(withIdentifier: "SingleView") as! SingleViewViewController
        singleViewViewController.searching = true
        singleViewViewController.pokemonURL = viewModel.getSelectedPokemonURL(index: index)
        self.navigationController?.pushViewController(singleViewViewController, animated: true)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.viewModel.filterPokemon(searchText: searchText)
        if searchText == "" {
            tableView.isHidden = true
        } else {
            tableView.isHidden = false
        }
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.viewModel.filterPokemon(searchText: "")
        tableView.isHidden = true
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if searchBar.text == "" {
            tableView.isHidden = true
        }
    }
}

extension SearchViewController: SearchViewable {
    func displayError(error: APIError) {
        self.showActionAlert(title: "Error",
        message: error.localizedDescription,
        actions: [UIAlertAction(title: "Cancel",
                                style: .cancel)],
            style: .alert)
    }
    
    func stopLoadingIndicator() {
        self.tableView.reloadData()
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else { return UITableViewCell() }
        cell.textLabel?.text = viewModel.getPokemonName(index: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        moveToSingleView(index: indexPath.row)
    }
}
