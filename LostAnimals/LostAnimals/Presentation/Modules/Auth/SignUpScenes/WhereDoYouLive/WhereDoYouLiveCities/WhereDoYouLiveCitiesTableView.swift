//
//  WhereDoYouLiveCitiesTableView.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 12/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

// MARK: - Functions
extension WhereDoYouLiveCitiesViewController {
    func configureTableview(_ tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CityTableViewCell.self)
    }
}

// MARK: - UITableViewDataSource
extension WhereDoYouLiveCitiesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(CityTableViewCell.self)
        cell.display(summary: CityTableViewCellSummary(cityName: viewModel.filteredCities[indexPath.row]))
        return cell
    }
}

// MARK: - UITableViewDelegate
extension WhereDoYouLiveCitiesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedIndexPath = tableView.indexPathForSelectedRow else { return }
        tableView.deselectRow(at: selectedIndexPath, animated: true)
        viewModel.didPressCity(city: viewModel.filteredCities[selectedIndexPath.row])
    }
}
