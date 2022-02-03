//
//  PostBuilder.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 3/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class PostBuilder {
    
    func build(comesFrom: PostComesFrom, post: Post) -> PostViewController {
        
        let viewController = UIViewController.instantiate(viewController: PostViewController.self)
        
        let router = PostRouter(viewController: viewController)
        let viewModel = PostViewModel(router: router, comesFrom: comesFrom, post: post)
        
        viewController.viewModel = viewModel
        
        return viewController
    }
}
