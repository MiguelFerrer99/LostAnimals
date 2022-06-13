//
//  ExploreViewModel.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 29/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

final class ExploreViewModel {
    // MARK: - Properties
    private let router: ExploreRouter
    var posts: [Post] = []
    var isLoading = true
    
    // MARK: - Services
    let postService = PostService()
    
    // MARK: - Init
    required init(router: ExploreRouter) {
        self.router = router
    }
}

// MARK: - Life cycle
extension ExploreViewModel {
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
extension ExploreViewModel {
    func getPosts(completion: @escaping (() -> ())) {
        postService.getPosts { result in
            switch result {
            case .success(let posts):
                self.posts = posts
                completion()
            case .error(let error):
                showErrorPopup(title: error, action: nil)
                completion()
            }
        }
    }
    
    func didPressAnimalFilter(loadData: Bool) {
        self.router.goToAnimalFilter(loadData: loadData)
    }
    
    func didPressSavedPosts() {
        if Cache.get(boolFor: .logged) {
            self.router.goToSavedPosts()
        } else {
            showGuestPopup()
        }
    }
    
    func didPressPost(post: Post) {
        self.router.goToPost(post: post)
    }
    
    func goToMyProfile() {
        self.router.goToMyProfile()
    }
}
