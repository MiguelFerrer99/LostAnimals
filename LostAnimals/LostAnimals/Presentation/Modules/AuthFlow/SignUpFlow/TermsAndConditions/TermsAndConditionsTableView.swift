//
//  TermsAndConditionsTableView.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 29/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

extension TermsAndConditionsViewController: UITableViewDelegate, UITableViewDataSource {
  func configureTableView(_ tableView: UITableView) {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(TermTableViewCell.self)
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return Constants.termsAndConditions.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let termAndCondition = Constants.termsAndConditions[indexPath.row]
    let summary = TermTableViewCellSummary(title: termAndCondition.title, description: termAndCondition.description)
    let cell = tableView.dequeue(TermTableViewCell.self)
    cell.display(summary: summary)
    return cell
  }
}
