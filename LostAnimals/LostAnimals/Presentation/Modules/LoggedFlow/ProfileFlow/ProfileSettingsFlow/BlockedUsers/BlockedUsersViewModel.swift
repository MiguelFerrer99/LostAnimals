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
    var isLoading = true
    var myBlockedUsers: [User] = []
    
    // MARK: - Services
    let userService = UserService()
    
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
extension BlockedUsersViewModel {
    func getBlockedUsers(completion: @escaping () -> Void) {
        userService.getBlockedUsers { result in
            switch result {
            case .success(let blockedUsers):
                self.myBlockedUsers = blockedUsers
                completion()
            case .error(let error): showErrorPopup(title: error)
            }
        }
    }
    
    func unblockUser(userID: String, completion: @escaping () -> Void) {
        userService.unblockUser(userID: userID) { result in
            switch result {
            case .success: completion()
            case .error(let error): showErrorPopup(title: error)
            }
        }
    }
}
