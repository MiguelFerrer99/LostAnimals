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
    
    func goToSavedPosts() {
        let viewController = Container.shared.savedPostsBuilder().build()
        DispatchQueue.main.async {
            self.viewController?.push(viewController: viewController)
        }
    }
    
    func goToPost(post: Post) {
        let viewController = Container.shared.postBuilder().build(comesFrom: .explore, post: post)
        DispatchQueue.main.async {
            self.viewController?.push(viewController: viewController)
        }
    }
}
