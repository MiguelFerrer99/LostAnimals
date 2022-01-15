//
//  PostOptionsPopupViewModel.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 3/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import Foundation
import UIKit

final class PostOptionsPopupViewModel {
  
  // MARK: - Properties
  private let router: PostOptionsPopupRouter
  let comesFrom: PostComesFrom
  let post: Post
  
  // MARK: - Init
  required init(router: PostOptionsPopupRouter, comesFrom: PostComesFrom, post: Post) {
    self.router = router
    self.comesFrom = comesFrom
    self.post = post
  }
}

// MARK: - Life cycle
extension PostOptionsPopupViewModel {
  func viewReady() {
    // Called when view is loaded and ready
  }
  
  func viewDidAppear() {
    // Called when view has appeared
  }
}

// MARK: - Functions
extension PostOptionsPopupViewModel {
  func didPressDismissButton() {
    self.router.dismissPostOptionsPopup()
  }
  
  func didPressEditPostButton() {
    self.router.dismissPostOptionsPopupAndGoToEditPost()
  }
  
  func didPressReportPostButton() {
    let logged = Cache.get(boolFor: .logged)
    if logged {
      self.router.dismissPostOptionsPopup()
      NotificationCenter.default.post(name: .ShowSuccessPopupFromPostOptionsPopup, object: nil)
    } else {
      self.router.dismissPostOptionsPopupAndShowGuestPopup()
    }
  }
  
  func didPressSharePostButton() {
    guard let imageToShare = createImageToShare() else { return }
    self.router.dismissPostOptionsAndShowActivityViewController(postImageToShare: imageToShare)
  }
  
  func createImageToShare() -> UIImage? {
    var bgImage: UIImage?
    switch post.postType {
    case .lost:
      bgImage = UIImage(named: "LostAnimalImageToShare")
    case .found:
      bgImage = UIImage(named: "FoundAnimalImageToShare")
    case .adopt:
      bgImage = UIImage(named: "ToAdoptAnimalImageToShare")
    }
    guard let animalImage = post.animal.images.first, let stickerImage = animalImage, let bgImage = bgImage else { return nil }

//    guard let returnedImage = stickerImage.drawIn(bgImage: bgImage,
//                                                  position: CGRect(x: bgImage.size.width/2 - 250, y: bgImage.size.height/2 - 250, width: 500, height: 500))
    else { return nil }
    
    return nil
  }
}
