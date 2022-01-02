//
//  AnimalFilterPopupTableView.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 2/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import Foundation
import UIKit

extension AnimalFilterPopupViewController: UITableViewDelegate, UITableViewDataSource {
  func configureTableView(_ tableView: UITableView) {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(AnimalFilterTableViewCell.self)
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return Constants.animalTypes.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let animalType = Constants.animalTypes[indexPath.row]
    let summary = AnimalFilterTableViewCellSummary(animalTypeTitle: animalType.rawValue)
    let cell = tableView.dequeue(AnimalFilterTableViewCell.self)
    cell.display(summary: summary)
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    enableApplyFilterButton()
  }
  
  func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    if tableView.indexPathsForSelectedRows?.isEmpty ?? true {
      disableApplyFilterButton()
    }
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 40
  }
}
