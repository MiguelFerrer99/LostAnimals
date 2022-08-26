//
//  NewPostGenericBuilder.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 17/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class NewPostGenericBuilder {}

// MARK: - Functions
extension NewPostGenericBuilder {
    func build(postType: PostType, postToLoad: Post? = nil, imagesToLoad: [UIImage]? = nil) -> NewPostGenericViewController {
        let viewController = UIViewController.instantiate(viewController: NewPostGenericViewController.self)
        let router = NewPostGenericRouter(viewController: viewController)
        let viewModel = NewPostGenericViewModel(router: router, postType: postType, postToLoad: postToLoad, imagesToLoad: imagesToLoad)
        viewController.viewModel = viewModel
        return viewController
    }
}
