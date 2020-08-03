//
//  UIViewControllerExtension.swift
//  Pokemon
//
//  Created by Brandon Gouws on 2020/07/31.
//  Copyright © 2020 DVT. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showActionAlert(title: String, message: String, actions: [UIAlertAction], style: UIAlertController.Style) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: style)
        for action in actions {
            alert.addAction(action)
        }
        if let popoverController = alert.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX,
                                                  y: self.view.bounds.midY,
                                                  width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        present(alert, animated: true)
    }
    
    func styleNavigationBar(searchbar: Bool) {
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        let navigationItem = self.navigationItem
        navigationBar.prefersLargeTitles = true
        navigationBar.backgroundColor = .systemRed
        if searchbar {
            let searchController = UISearchController(searchResultsController: nil)
            navigationItem.searchController = searchController
            guard let searchBarTextField = self.navigationItem.searchController?.searchBar.searchTextField else {
                return
            }
            searchController.searchBar.backgroundColor = .systemRed
            searchBarTextField.backgroundColor = .lightGray
            searchBarTextField.textColor = .black
            searchBarTextField.placeholder = "Search Pokemon"
            navigationItem.searchController?.obscuresBackgroundDuringPresentation = false
            navigationItem.hidesSearchBarWhenScrolling = false
        }
    }
}
