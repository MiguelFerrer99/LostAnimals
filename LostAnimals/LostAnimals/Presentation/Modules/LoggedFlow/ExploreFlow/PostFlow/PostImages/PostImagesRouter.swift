//
//  PostImagesRouter.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 7/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class PostImagesRouter {
    // MARK: - Properties
    private weak var viewController: PostImagesViewController?
    
    // MARK: - Init
    required init(viewController: PostImagesViewController?) {
        self.viewController = viewController
    }
    
    // MARK: - Functions
    func dismissPostImages() {
        self.viewController?.dismissCurrentView(completion: nil)
    }
}
