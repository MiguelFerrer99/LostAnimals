//
//  SelectPhotoPopupBuilder.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 6/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class SelectPhotoPopupBuilder {
  
  func build(showRemoveOption: Bool, indexImageView: Int) -> SelectPhotoPopupViewController {
    
    let viewController = UIViewController.instantiate(viewController: SelectPhotoPopupViewController.self)
    
    let router = SelectPhotoPopupRouter(viewController: viewController)
    let viewModel = SelectPhotoPopupViewModel(router: router, showRemoveOption: showRemoveOption, indexImageView: indexImageView)
    
    viewController.viewModel = viewModel
    
    return viewController
  }
}
