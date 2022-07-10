//
//  BlockedUsersProtocols.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 5/2/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

// MARK: - UnblockUserDelegate
extension BlockedUsersViewController: UnblockUserDelegate {
    func unblockUser(userID: String) {
        unblockUserWith(userID: userID)
    }
}
