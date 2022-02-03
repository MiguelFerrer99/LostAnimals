//
//  PostOptionsPopupBuilder.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 3/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class PostOptionsPopupBuilder {
    
    func build(comesFrom: PostComesFrom, post: Post) -> PostOptionsPopupViewController {
        
        let viewController = UIViewController.instantiate(viewController: PostOptionsPopupViewController.self)
        
        let router = PostOptionsPopupRouter(viewController: viewController)
        let viewModel = PostOptionsPopupViewModel(router: router, comesFrom: comesFrom, post: post)
        
        viewController.viewModel = viewModel
        
        return viewController
    }
}
