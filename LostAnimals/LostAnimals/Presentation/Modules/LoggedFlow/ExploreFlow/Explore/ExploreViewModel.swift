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
    
    func viewDidAppear() {
        // Called when view has appeared
        Filters.resetFilters()
        NotificationCenter.default.post(name: .UpdateFiltersUI, object: nil)
    }
}

// MARK: - Functions
extension ExploreViewModel {
    func didPressPostsFilterPopup(filterType: FilterType, loadData: Bool) {
        self.router.goToFilterPopup(filterType: filterType, loadData: loadData)
    }
    
    func didPressSavedPosts() {
        let logged = Cache.get(boolFor: .logged)
        if logged {
            self.router.goToSavedPosts()
        } else {
            showGuestPopup()
        }
    }
    
    func didPressPost(post: Post) {
        self.router.goToPost(post: post)
    }
}
