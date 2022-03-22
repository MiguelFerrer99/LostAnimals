//
//  BlockedUsersViewModel.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 3/2/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

final class BlockedUsersViewModel {
    // MARK: - Properties
    private let router: BlockedUsersRouter
    
    // MARK: - Init
    required init(router: BlockedUsersRouter) {
        self.router = router
    }
}

// MARK: - Life cycle
extension BlockedUsersViewModel {
    func viewReady() {
        // Called when view is loaded and ready
    }
    
    func viewDidAppear() {
        // Called when view has appeared
    }
}

// MARK: - Functions
extension BlockedUsersViewModel {}
