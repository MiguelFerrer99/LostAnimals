//
//  WhereCanWeFindYouSearchBar.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 20/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

// MARK: - Functions
extension WhereCanWeFindYouViewController {
    func configureSearchController(_ searchController: UISearchController) {
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search your address..."
        searchController.searchBar.barStyle = .black
        searchController.searchBar.searchTextField.tintColor = .customWhite
        searchController.searchBar.searchTextField.backgroundColor = .customBlack
        searchController.searchBar.searchTextField.leftView?.tintColor = .customWhite
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
}

// MARK: - UISearchBarDelegate
extension WhereCanWeFindYouViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchCompleter.queryFragment = searchText
    }
}
