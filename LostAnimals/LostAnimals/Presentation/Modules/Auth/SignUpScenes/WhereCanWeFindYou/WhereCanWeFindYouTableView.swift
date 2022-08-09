//
//  WhereCanWeFindYouTableView.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 20/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

// MARK: - Functions
extension WhereCanWeFindYouViewController {
    func configureTableView(_ tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(LoadingTableViewCell.self)
        tableView.register(CurrentLocationTableViewCell.self)
        tableView.register(AddressTableViewCell.self)
    }
}

// MARK: - UITableViewDataSource
extension WhereCanWeFindYouViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (viewModel.searchResults.isEmpty && userSharedLocation()) || viewModel.loadingLocation { return 1 }
        else { return viewModel.searchResults.count }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if viewModel.loadingLocation {
            tableView.separatorStyle = .none
            tableView.isUserInteractionEnabled = false
            let cell = tableView.dequeue(LoadingTableViewCell.self)
            return cell
        } else if viewModel.searchResults.isEmpty && userSharedLocation() {
            let cell = tableView.dequeue(CurrentLocationTableViewCell.self)
            return cell
        } else {
            let searchResult = viewModel.searchResults[indexPath.row]
            let cell = tableView.dequeue(AddressTableViewCell.self)
            cell.display(summary: AddressTableViewCellSummary(searchResult: searchResult))
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let tableViewRealHeight = tableView.frame.height - 200
        return viewModel.loadingLocation ? tableViewRealHeight : UITableView.automaticDimension
    }
}

// MARK: - UITableViewDelegate
extension WhereCanWeFindYouViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if viewModel.loadingLocation {
            // Do nothing
        } else if viewModel.searchResults.isEmpty && userSharedLocation() {
            getUserCurrentLocation()
        } else {
            let searchResult = viewModel.searchResults[indexPath.row]
            viewModel.didPressAddress(searchResult: searchResult)
        }
    }
}
