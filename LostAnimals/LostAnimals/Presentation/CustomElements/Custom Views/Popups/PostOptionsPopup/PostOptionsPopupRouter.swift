//
//  PostOptionsPopupRouter.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 3/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class PostOptionsPopupRouter {
  // MARK: - Properties
  private weak var viewController: UIViewController?
  
  // MARK: - Init
  required init(viewController: UIViewController?) {
    self.viewController = viewController
  }
  
  // MARK: - Functions
  func dismissPostOptionsPopup() {
    DispatchQueue.main.async {
      self.viewController?.dismissCurrentView(completion: nil)
    }
  }
  
  func dismissPostOptionsPopupAndGoToEditPost() {
    DispatchQueue.main.async {
      self.viewController?.dismissCurrentView(completion: {
        NotificationCenter.default.post(name: .GoToEditPostFromPostOptionsPopup, object: nil)
      })
    }
  }
  
  func dismissPostOptionsPopupAndShowGuestPopup() {
    DispatchQueue.main.async {
      self.viewController?.dismissCurrentView(completion: {
        NotificationCenter.default.post(name: .ShowGuestPopupFromPostOptionsPopup, object: nil)
      })
    }
  }
  
  func dismissPostOptionsPopupAndShowSuccessPopup() {
    DispatchQueue.main.async {
      self.viewController?.dismissCurrentView(completion: {
        NotificationCenter.default.post(name: .ShowSuccessPopupFromPostOptionsPopup, object: nil)
      })
    }
  }
  
  func dismissPostOptionsPopupAndShowErrorPopup() {
    DispatchQueue.main.async {
      self.viewController?.dismissCurrentView(completion: {
        NotificationCenter.default.post(name: .ShowErrorPopupFromPostOptionsPopup, object: nil)
      })
    }
  }
  
  func dismissPostOptionsAndShowActivityViewController(postImageToShare: UIImage) {
    DispatchQueue.main.async {
      self.viewController?.dismissCurrentView(completion: {
        let userInfo: [String: UIImage] = ["postImageToShare": postImageToShare]
        NotificationCenter.default.post(name: .ShowActivityViewControllerFromPostOptionsPopup, object: nil, userInfo: userInfo)
      })
    }
  }
}
