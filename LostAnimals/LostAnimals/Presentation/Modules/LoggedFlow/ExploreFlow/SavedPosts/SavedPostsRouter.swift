//
//  SavedPostsRouter.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 3/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class SavedPostsRouter {
    // MARK: - Properties
    private weak var viewController: SavedPostsViewController?
    
    // MARK: - Init
    required init(viewController: SavedPostsViewController?) {
        self.viewController = viewController
    }
}

// MARK: - Functions
extension SavedPostsRouter {
    func goToFilterPopup(filterType: FilterType, loadData: Bool) {
        DispatchQueue.main.async {
            let viewController: ViewController!
            switch filterType {
            case .animal:
                viewController = Container.shared.animalFilterPopupBuilder().build(loadData: loadData)
            case .location:
                viewController = Container.shared.locationFilterPopupBuilder().build(loadData: loadData)
            case .date:
                viewController = Container.shared.dateFilterPopupBuilder().build(loadData: loadData)
            default: return
            }
            self.viewController?.present(viewController: viewController, completion: nil)
        }
    }
    
    func goToPost(post: Post, comesFrom: PostComesFrom) {
        DispatchQueue.main.async {
            let viewController = Container.shared.postBuilder().build(comesFrom: comesFrom, post: post)
            self.viewController?.push(viewController: viewController)
        }
    }
    
    func back() {
        self.viewController?.pop()
    }
}
