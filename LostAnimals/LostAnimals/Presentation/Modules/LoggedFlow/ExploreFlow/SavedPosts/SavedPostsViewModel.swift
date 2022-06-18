//
//  SavedPostsViewModel.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 3/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import Foundation

final class SavedPostsViewModel {
    // MARK: - Properties
    private let router: SavedPostsRouter
    private let comesFrom: PostComesFrom
    var savedPosts: [Post] = []
    var isLoading = true
    
    // MARK: - Services
    let userService = UserService()
    let postService = PostService()
    
    // MARK: - Init
    required init(router: SavedPostsRouter, comesFrom: PostComesFrom) {
        self.router = router
        self.comesFrom = comesFrom
    }
}

// MARK: - Life cycle
extension SavedPostsViewModel {
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
extension SavedPostsViewModel {
    func getSavedPosts(completion: @escaping (() -> ())) {
        postService.getSavedPosts { result in
            switch result {
            case .success(let savedPosts):
                self.savedPosts = savedPosts
                completion()
            case .error(let error):
                showErrorPopup(title: error, action: nil)
                completion()
            }
        }
    }
    
    func didPressPost(post: Post) {
        self.router.goToPost(post: post, comesFrom: comesFrom)
    }
    
    func goBack() {
        self.router.back()
    }
}
