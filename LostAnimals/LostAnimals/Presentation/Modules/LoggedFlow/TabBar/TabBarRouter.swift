//
//  TabBarRouter.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 29/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

final class TabBarRouter {
    // MARK: - Properties
    private weak var viewController: UIViewController?
    
    // MARK: - Init
    required init(viewController: UIViewController?) {
        self.viewController = viewController
    }
}

// MARK: - Functions
extension TabBarRouter {
    func goToExplore() -> ViewController {
        Container.shared.exploreBuilder().build()
    }
    
    func goToNewPost() {
        DispatchQueue.main.async {
            let viewController = Container.shared.newPostBuilder().build().embeddedInNavigation()
            viewController.modalPresentationStyle = .overFullScreen
            self.viewController?.present(viewController: viewController, completion: nil)
        }
    }
    
    func goToProfile() -> ViewController {
        Container.shared.profileBuilder().build(user: User.shared ?? Constants.emptyUser)
    }
}
