//
//  EditPostBuilder.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 4/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class EditPostBuilder {
  
  func build(post: Post) -> EditPostViewController {
    
    let viewController = UIViewController.instantiate(viewController: EditPostViewController.self)
    
    let router = EditPostRouter(viewController: viewController)
    let viewModel = EditPostViewModel(router: router, post: post)
    
    viewController.viewModel = viewModel
    
    return viewController
  }
}
