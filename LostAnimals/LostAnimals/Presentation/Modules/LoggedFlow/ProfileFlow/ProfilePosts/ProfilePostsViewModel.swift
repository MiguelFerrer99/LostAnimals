//
//  ProfilePostsViewModel.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 3/2/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import Foundation

final class ProfilePostsViewModel {
    // MARK: - Properties
    private let router: ProfilePostsRouter
    let user: User
    let isMyprofile: Bool
    
    // MARK: - Init
    required init(router: ProfilePostsRouter, user: User) {
        self.router = router
        self.user = user
        self.isMyprofile = User.shared == user
    }
}

// MARK: - Life cycle
extension ProfilePostsViewModel {
    func viewReady() {
        // Called when view is loaded and ready
    }
    
    func viewDidAppear() {
        // Called when view has appeared
        Filters.resetFilters()
        NotificationCenter.default.post(name: .UpdateFiltersUI, object: nil)
    }
}

// MARK: - Functions
extension ProfilePostsViewModel {
    func didPressPostsFilterPopup(filterType: FilterType, loadData: Bool) {
        self.router.goToFilterPopup(filterType: filterType, loadData: loadData)
    }
    
    func didPressPost(post: Post) {
        self.router.goToPost(post: post)
    }
}
