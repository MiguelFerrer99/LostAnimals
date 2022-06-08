//
//  EditPostBuilder.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 4/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class EditPostBuilder {}

// MARK: - Functions
extension EditPostBuilder {
    func build(post: Post, postImages: [UIImage]) -> EditPostViewController {
        let viewController = UIViewController.instantiate(viewController: EditPostViewController.self)
        let router = EditPostRouter(viewController: viewController)
        let viewModel = EditPostViewModel(router: router, post: post, postImages: postImages)
        viewController.viewModel = viewModel
        return viewController
    }
}
