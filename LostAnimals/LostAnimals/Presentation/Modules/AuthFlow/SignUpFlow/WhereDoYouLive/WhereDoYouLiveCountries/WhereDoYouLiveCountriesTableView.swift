//
//  WhereDoYouLiveCountriesTableView.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 10/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

extension WhereDoYouLiveCountriesViewController: UITableViewDelegate, UITableViewDataSource {
  func configureTableview(_ tableView: UITableView) {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(CountryTableViewCell.self)
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.filteredCountries.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeue(CountryTableViewCell.self)
    cell.display(summary: CountryTableViewCellSummary(countryName: viewModel.filteredCountries[indexPath.row].nameEN, dialCode: viewModel.filteredCountries[indexPath.row].dialCode, comesFrom: viewModel.comesFrom))
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let selectedIndexPath = tableView.indexPathForSelectedRow else { return }
    tableView.deselectRow(at: selectedIndexPath, animated: true)
    viewModel.didPressCountryCell(country: viewModel.filteredCountries[indexPath.row], cities: viewModel.filteredCountries[indexPath.row].cities)
  }
}
