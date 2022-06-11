//
//  ProfilePostsRouter.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 3/2/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class ProfilePostsRouter {
    // MARK: - Properties
    private weak var viewController: ProfilePostsViewController?
    
    // MARK: - Init
    required init(viewController: ProfilePostsViewController?) {
        self.viewController = viewController
    }
}

// MARK: - Functions
extension ProfilePostsRouter {
    func goToFilterPopup(filterType: FilterType, loadData: Bool) {
        DispatchQueue.main.async {
            let viewController: ViewController!
            switch filterType {
            case .animal:
                viewController = Container.shared.animalFilterPopupBuilder().build(loadData: loadData)
            default: return
            }
            self.viewController?.present(viewController: viewController, completion: nil)
        }
    }
    
    func goToPost(post: Post) {
        DispatchQueue.main.async {
            let viewController = Container.shared.postBuilder().build(comesFrom: .profile, post: post)
            self.viewController?.push(viewController: viewController)
        }
    }
}
