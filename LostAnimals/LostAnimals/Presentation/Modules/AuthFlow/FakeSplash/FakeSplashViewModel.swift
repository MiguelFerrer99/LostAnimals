//
//  FakeSplashViewModel.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 27/3/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import Firebase

final class FakeSplashViewModel {
    // MARK: - Properties
    private let router: FakeSplashRouter
    
    // MARK: - Services
    let userService = UserService()
    
    // MARK: - Init
    required init(router: FakeSplashRouter) {
        self.router = router
    }
}

// MARK: - Life cycle
extension FakeSplashViewModel {
    func viewReady() {
        // Called when view is loaded and ready
    }
    
    func viewDidAppear() {
        // Called when view has appeared
    }
}

// MARK: - Functions
extension FakeSplashViewModel {
    func getMe(completion: @escaping ((User?) -> ())) {
        if let currentUser = Auth.auth().currentUser {
            self.userService.getUser(id: currentUser.uid) { user in
                if let user = user { completion(user)
                } else {
                    completion(nil)
                    return
                }
            }
        } else {
            completion(nil)
            return
        }
    }
    
    func goToStartup() {
        self.router.goToStartup()
    }
    
    func goToOnboarding() {
        self.router.goToOnboarding()
    }
    
    func goToTabBar() {
        self.router.goToTabBar()
    }
}
