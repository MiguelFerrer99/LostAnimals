//
//  SelectPhotoPopupRouter.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 6/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class SelectPhotoPopupRouter {
  // MARK: - Properties
  private weak var viewController: ViewController?
  
  // MARK: - Init
  required init(viewController: ViewController?) {
    self.viewController = viewController
  }
  
  // MARK: - Functions
  func dismissSelectPhotoPopup() {
    DispatchQueue.main.async {
      self.viewController?.dismissCurrentView(completion: nil)
    }
  }
  
  func dismissSelectPhotoPopupAndRemovePhoto(indexImageView: Int) {
    DispatchQueue.main.async {
      self.viewController?.dismissCurrentView(completion: {
        let userInfo: [String: Int] = ["indexImageView": indexImageView]
        NotificationCenter.default.post(name: .RemovePhotoFromSelectPhotoPopup, object: nil, userInfo: userInfo)
      })
    }
  }
  
  func dismissSelectPhotoPopupAndChooseFromLibrary(indexImageView: Int) {
    DispatchQueue.main.async {
      self.viewController?.dismissCurrentView(completion: {
        let userInfo: [String: Int] = ["indexImageView": indexImageView]
        NotificationCenter.default.post(name: .ChooseFromLibraryFromSelectPhotoPopup, object: nil, userInfo: userInfo)
      })
    }
  }
  
  func dismissSelectPhotoPopupAndTakeAPhoto(indexImageView: Int) {
    DispatchQueue.main.async {
      self.viewController?.dismissCurrentView(completion: {
        let userInfo: [String: Int] = ["indexImageView": indexImageView]
        NotificationCenter.default.post(name: .TakeAPhotoFromSelectPhotoPopup, object: nil, userInfo: userInfo)
      })
    }
  }
}
