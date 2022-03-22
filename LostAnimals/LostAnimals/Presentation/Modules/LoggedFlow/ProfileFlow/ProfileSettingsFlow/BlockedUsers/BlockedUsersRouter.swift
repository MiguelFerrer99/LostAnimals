//
//  BlockedUsersRouter.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 3/2/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class BlockedUsersRouter {
    // MARK: - Properties
    private weak var viewController: BlockedUsersViewController?
    
    // MARK: - Init
    required init(viewController: BlockedUsersViewController?) {
        self.viewController = viewController
    }
}
