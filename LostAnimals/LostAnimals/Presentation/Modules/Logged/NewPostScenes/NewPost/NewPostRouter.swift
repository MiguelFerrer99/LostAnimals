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
    private weak var viewController: NewPostViewController?
    
    // MARK: - Init
    required init(viewController: NewPostViewController?) {
        self.viewController = viewController
    }
}

// MARK: - Functions
extension NewPostRouter {
    func dismissNewPost() {
        self.viewController?.dismissCurrentView(completion: nil)
    }
    
    func goToNewPostGeneric(postType: PostType) {
        DispatchQueue.main.async {
            let viewController = Container.shared.newPostGenericBuilder().build(postType: postType)
            self.viewController?.push(viewController: viewController)
        }
    }
}
