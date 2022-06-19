//
//  WhereDoYouLiveCountriesTableView.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 10/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

// MARK: - Functions
extension WhereDoYouLiveCountriesViewController {
    func configureTableview(_ tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CountryTableViewCell.self)
    }
}

// MARK: - UITableViewDataSource
extension WhereDoYouLiveCountriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredCountries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(CountryTableViewCell.self)
        var countryName = viewModel.filteredCountries[indexPath.row].nameEN
        if let languageCode = Locale.current.languageCode, languageCode == "es" {
            countryName = viewModel.filteredCountries[indexPath.row].nameES
        }
        let summary = CountryTableViewCellSummary(countryName: countryName,
                                                  dialCode: viewModel.filteredCountries[indexPath.row].dialCode,
                                                  comesFrom: viewModel.comesFrom)
        cell.display(summary: summary)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension WhereDoYouLiveCountriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedIndexPath = tableView.indexPathForSelectedRow else { return }
        tableView.deselectRow(at: selectedIndexPath, animated: true)
        viewModel.didPressCountryCell(country: viewModel.filteredCountries[indexPath.row], cities: viewModel.filteredCountries[indexPath.row].cities)
    }
}
