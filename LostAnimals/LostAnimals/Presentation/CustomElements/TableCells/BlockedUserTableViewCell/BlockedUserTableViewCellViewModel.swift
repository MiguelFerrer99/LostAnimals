//
//  BlockedUserTableViewCellViewModel.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 3/2/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import Foundation

class BlockedUserTableViewCellViewModel: ViewModel {
    // MARK: - Properties
    let userID: String
    
    // MARK: - Init
    init(userID: String) {
        self.userID = userID
    }
}
