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
  func goBack() {
    DispatchQueue.main.async {
      self.viewController?.pop()
    }
  }
  
  func goToPostImages(postImages: [UIImage?], indexPostImages: Int) {
    let viewController = Container.shared.postImagesBuilder().build(postImages: postImages, indexPostImage: indexPostImages)
    DispatchQueue.main.async {
      self.viewController?.present(viewController: viewController, completion: nil)
    }
  }
  
  func goToLocation(coordinates: Coordinates, animal: Animal) {
    let viewController = Container.shared.locationBuilder().build(coordinates: coordinates, animal: animal)
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
  
  func showContactWithPopup(authorSocialMedias: SocialMedias) {
    let viewController = Container.shared.contactWithPopupBuilder().build(authorSocialMedias: authorSocialMedias)
    DispatchQueue.main.async {
      self.viewController?.present(viewController: viewController, completion: nil)
    }
  }
  
  func goToPostOptionsPopup(comesFrom: PostComesFrom, post: Post) {
    let viewController = Container.shared.postOptionsPopupBuilder().build(comesFrom: comesFrom, post: post)
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
