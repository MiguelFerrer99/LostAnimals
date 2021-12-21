//
//  WhereDoYouLiveCountriesSearchBar.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 19/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

extension WhereDoYouLiveCountriesViewController: UISearchBarDelegate {
  func configureSearchController(_ searchController: UISearchController) {
    searchController.hidesNavigationBarDuringPresentation = false
    searchController.searchBar.delegate = self
    searchController.searchBar.placeholder = "Search your country..."
    searchController.searchBar.barStyle = .black
    searchController.searchBar.searchTextField.tintColor = .customWhite
    searchController.searchBar.searchTextField.backgroundColor = .customBlack
    searchController.searchBar.searchTextField.leftView?.tintColor = .customWhite
    self.navigationItem.searchController = searchController
    self.navigationItem.hidesSearchBarWhenScrolling = false
  }
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    if searchText.isEmpty {
      self.viewModel.filteredCountries = self.viewModel.countries
    } else {
      self.viewModel.filteredCountries.removeAll()
      self.viewModel.countries.forEach { country in
        if country.nameEN.lowercased().contains(searchText.lowercased()) {
          self.viewModel.filteredCountries.append(country)
        }
      }
    }
    self.countriesTableView.reloadData()
  }
}
