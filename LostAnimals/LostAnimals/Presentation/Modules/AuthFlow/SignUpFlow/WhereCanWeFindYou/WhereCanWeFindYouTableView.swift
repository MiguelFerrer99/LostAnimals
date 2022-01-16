//
//  WhereCanWeFindYouTableView.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 20/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

extension WhereCanWeFindYouViewController: UITableViewDelegate, UITableViewDataSource {
  func configureTableView(_ tableView: UITableView) {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(AddressTableViewCell.self)
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.searchResults.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let searchResult = viewModel.searchResults[indexPath.row]
    let cell = tableView.dequeue(AddressTableViewCell.self)
    cell.display(summary: AddressTableViewCellSummary(searchResult: searchResult))
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let selectedIndexPath = tableView.indexPathForSelectedRow else { return }
    tableView.deselectRow(at: selectedIndexPath, animated: true)
    let searchResult = viewModel.searchResults[selectedIndexPath.row]
    viewModel.didPressAddress(searchResult: searchResult)
  }
}
