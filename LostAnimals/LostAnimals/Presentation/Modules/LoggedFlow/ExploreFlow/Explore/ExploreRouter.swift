//
//  ExploreRouter.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 29/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

final class ExploreRouter {
    // MARK: - Properties
    private weak var viewController: ExploreViewController?
    
    // MARK: - Init
    required init(viewController: ExploreViewController?) {
        self.viewController = viewController
    }
}

// MARK: - Functions
extension ExploreRouter {
    func goToMyProfile() {
        DispatchQueue.main.async {
            guard let tabBarController = self.viewController?.tabBarController else { return }
            tabBarController.selectedIndex = TabBarItem.profile.rawValue
        }
    }
    
    func goToFilterPopup(filterType: FilterType, loadData: Bool) {
        DispatchQueue.main.async {
            switch filterType {
            case .animal:
                let viewController = Container.shared.animalFilterPopupBuilder().build(loadData: loadData)
                self.viewController?.present(viewController: viewController, completion: nil)
            default: return
            }
        }
    }
    
    func goToSavedPosts() {
        DispatchQueue.main.async {
            let viewController = Container.shared.savedPostsBuilder().build(comesFrom: .explore)
            self.viewController?.push(viewController: viewController)
        }
    }
    
    func goToPost(post: Post) {
        DispatchQueue.main.async {
            let viewController = Container.shared.postBuilder().build(comesFrom: .explore, post: post)
            viewController.delegate = self.viewController
            self.viewController?.push(viewController: viewController)
        }
    }
}
