//
//  NewPostRouter.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 29/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

final class NewPostRouter {
    // MARK: - Properties
    private weak var viewController: ViewController?
    
    // MARK: - Init
    required init(viewController: ViewController?) {
        self.viewController = viewController
    }
    
    // MARK: - Functions
    func dismissNewPost() {
        DispatchQueue.main.async {
            self.viewController?.dismissCurrentView(completion: nil)
        }
    }
    
    func goToNewPostGeneric(postType: PostType) {
        let viewController = Container.shared.newPostGenericBuilder().build(postType: postType)
        DispatchQueue.main.async {
            self.viewController?.push(viewController: viewController)
        }
    }
}
