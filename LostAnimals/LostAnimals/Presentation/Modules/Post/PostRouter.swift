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
  func goToPostImages(postImages: [UIImage?], indexPostImages: Int) {
    let viewController = Container.shared.postImagesBuilder().build(postImages: postImages, indexPostImage: indexPostImages)
    DispatchQueue.main.async {
      self.viewController?.present(viewController: viewController, completion: nil)
    }
  }
  
  func goToLocation(location: Location, animal: Animal) {
    let viewController = Container.shared.locationBuilder().build(location: location, animal: animal)
    DispatchQueue.main.async {
      self.viewController?.push(viewController: viewController)
    }
  }
  
  func goToAuthorProfile() {
    let viewController = Container.shared.profileBuilder().build(hideBackButton: false)
    viewController.hidesBottomBarWhenPushed = true
    DispatchQueue.main.async {
      self.viewController?.push(viewController: viewController)
    }
  }
  
  func showContactWithPopup() {
    let viewController = Container.shared.contactWithPopupBuilder().build()
    DispatchQueue.main.async {
      self.viewController?.present(viewController: viewController, completion: nil)
    }
  }
  
  func goToPostOptionsPopup(comesFrom: PostComesFrom) {
    let viewController = Container.shared.postOptionsPopupBuilder().build(comesFrom: comesFrom)
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
