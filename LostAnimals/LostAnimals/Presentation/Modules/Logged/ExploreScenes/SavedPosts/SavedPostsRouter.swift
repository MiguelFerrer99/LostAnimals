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
