//
//  PostRouter.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 3/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class PostRouter {
  // MARK: - Properties
  private weak var viewController: ViewController?
  
  // MARK: - Init
  required init(viewController: ViewController?) {
    self.viewController = viewController
  }
  
  // MARK: - Functions
  func goToPostOptionsPopup() {
    let viewController = Container.shared.postOptionsPopupBuilder().build()
    DispatchQueue.main.async {
      self.viewController?.present(viewController: viewController, completion: nil)
    }
  }
  
  func goToEditPost(post: Post) {
    let viewController = Container.shared.editPostBuilder().build(post: post)
    DispatchQueue.main.async {
      self.viewController?.push(viewController: viewController)
    }
  }
}
