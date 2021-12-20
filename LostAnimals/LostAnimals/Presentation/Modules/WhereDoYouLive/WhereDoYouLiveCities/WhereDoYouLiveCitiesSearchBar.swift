//
//  WhereDoYouLiveCitiesSearchBar.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 20/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

extension WhereDoYouLiveCitiesViewController: UISearchBarDelegate {
  func configureSearchController(_ searchController: UISearchController) {
    searchController.searchBar.delegate = self
    searchController.hidesNavigationBarDuringPresentation = false
    searchController.searchBar.placeholder = "Search your city..."
    searchController.searchBar.tintColor = .customBlack
    searchController.searchBar.setIconColor(.customBlack)
    searchController.searchBar.setTextFieldColor(.customRed)
    searchController.searchBar.setPlaceholderColor(.customBlue)
    self.navigationItem.searchController = searchController
    self.navigationItem.hidesSearchBarWhenScrolling = false
  }
  
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
