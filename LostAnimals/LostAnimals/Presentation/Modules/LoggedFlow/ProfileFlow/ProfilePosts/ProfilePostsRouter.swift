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
        
        DispatchQueue.main.async {
            self.viewController?.present(viewController: viewController, completion: nil)
        }
    }
    
    func goToPost(post: Post) {
        let viewController = Container.shared.postBuilder().build(comesFrom: .explore, post: post)
        DispatchQueue.main.async {
            self.viewController?.push(viewController: viewController)
        }
    }
}
