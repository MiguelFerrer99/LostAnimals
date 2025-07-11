//
//  WhereDoYouLiveCitiesSearchBar.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 20/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

// MARK: - Functions
extension WhereDoYouLiveCitiesViewController {
    func configureSearchController(_ searchController: UISearchController) {
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = .WhereDoYouLiveCities.SearchBarPlaceholder()
        searchController.searchBar.barStyle = .black
        searchController.searchBar.searchTextField.tintColor = .customWhite
        searchController.searchBar.searchTextField.backgroundColor = .customBlack
        searchController.searchBar.searchTextField.leftView?.tintColor = .customWhite
        searchController.obscuresBackgroundDuringPresentation = false
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
}

// MARK: - UISearchBarDelegate
extension WhereDoYouLiveCitiesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            self.viewModel.filteredCities = self.viewModel.cities
        } else {
            self.viewModel.filteredCities.removeAll()
            self.viewModel.cities.forEach { city in
                if city.lowercased().contains(searchText.lowercased()) {
                    self.viewModel.filteredCities.append(city)
                }
            }
        }
        self.citiesTableView.reloadData()
    }
}
