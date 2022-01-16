//
//  PostImagesBuilder.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 7/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class PostImagesBuilder {
  
  func build(postImages: [UIImage?], indexPostImage: Int) -> PostImagesViewController {
    
    let viewController = UIViewController.instantiate(viewController: PostImagesViewController.self)
    
    let router = PostImagesRouter(viewController: viewController)
    let viewModel = PostImagesViewModel(router: router, postImages: postImages, indexPostImage: indexPostImage)
    
    viewController.viewModel = viewModel
    
    return viewController
  }
}
