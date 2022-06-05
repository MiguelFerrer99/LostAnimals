//
//  BlockedUsersTableView.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 3/2/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

// MARK: - Functions
extension BlockedUsersViewController {
    func configureTableView(_ tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(LoadingTableViewCell.self)
        tableView.register(BlockedUserTableViewCell.self)
    }
}

// MARK: - UITableViewDelegate
extension BlockedUsersViewController: UITableViewDelegate {}

// MARK: - UITableViewDataSource
extension BlockedUsersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.isLoading ? 1 : viewModel.myBlockedUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if viewModel.isLoading {
            let cell = tableView.dequeue(LoadingTableViewCell.self)
            return cell
        } else {
            let blockedUser = viewModel.myBlockedUsers[indexPath.row]
            let summary = BlockedUserTableViewCellSummary(user: blockedUser)
            let cell = tableView.dequeue(BlockedUserTableViewCell.self)
            cell.delegate = self
            cell.display(summary: summary)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.isLoading ? tableView.frame.height : 70
    }
}
