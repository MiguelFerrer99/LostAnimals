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
    let userID: Int
    
    // MARK: - Init
    init(userID: Int) {
        self.userID = userID
    }
}
