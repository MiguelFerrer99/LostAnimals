//
//  BlockedUsersTableView.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 3/2/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import Foundation
import UIKit

extension BlockedUsersViewController: UITableViewDelegate, UITableViewDataSource {
    func configureTableView(_ tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(BlockedUserTableViewCell.self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HardcodedData.exampleUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let blockedUser = HardcodedData.exampleUsers[indexPath.row]
        let summary = BlockedUserTableViewCellSummary(user: blockedUser)
        let cellVM = BlockedUserTableViewCellViewModel(userID: blockedUser.id)
        let cell = tableView.dequeue(BlockedUserTableViewCell.self, viewModel: cellVM)
        cell.delegate = self
        cell.display(summary: summary)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
