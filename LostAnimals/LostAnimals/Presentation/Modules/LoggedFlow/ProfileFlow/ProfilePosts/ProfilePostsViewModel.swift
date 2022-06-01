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
    let isMyProfile: Bool
    let posts: [Post]
    
    // MARK: - Services
    let postService = PostService()
    
    // MARK: - Init
    required init(router: ProfilePostsRouter, isMyProfile: Bool, posts: [Post]) {
        self.router = router
        self.isMyProfile = isMyProfile
        self.posts = posts
    }
}

// MARK: - Life cycle
extension ProfilePostsViewModel {
    func viewReady() {
        // Called when view is loaded and ready
    }
    
    func viewWillAppear() {
        // Called when view will appear
    }
    
    func viewDidAppear() {
        // Called when view has appeared
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
