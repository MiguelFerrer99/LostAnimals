//
//  BlockedUsersProtocols.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 5/2/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import Foundation

extension BlockedUsersViewController: UnblockUserDelegate {
    func unblockUser(userID: Int) {
        updateUserInteraction(to: false)
        // TODO: - Call API to unblock user
        blockedUsersTableView.reloadData()
        updateUserInteraction(to: true)
    }
}
