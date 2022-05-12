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
    func goToFilterPopup(filterType: FilterType, loadData: Bool) {
        DispatchQueue.main.async {
            switch filterType {
            case .animal:
                let viewController = Container.shared.animalFilterPopupBuilder().build(loadData: loadData)
                self.viewController?.present(viewController: viewController, completion: nil)
            case .location:
                let viewController = Container.shared.locationFilterPopupBuilder().build(loadData: loadData)
                self.viewController?.present(viewController: viewController, completion: nil)
            case .date:
                let viewController = Container.shared.dateFilterPopupBuilder().build(loadData: loadData)
                self.viewController?.present(viewController: viewController, completion: nil)
            default: return
            }
        }
    }
    
    func goToSavedPosts() {
        DispatchQueue.main.async {
            let viewController = Container.shared.savedPostsBuilder().build()
            self.viewController?.push(viewController: viewController)
        }
    }
    
    func goToPost(post: Post) {
        DispatchQueue.main.async {
            let viewController = Container.shared.postBuilder().build(comesFrom: .explore, post: post)
            self.viewController?.push(viewController: viewController)
        }
    }
}
