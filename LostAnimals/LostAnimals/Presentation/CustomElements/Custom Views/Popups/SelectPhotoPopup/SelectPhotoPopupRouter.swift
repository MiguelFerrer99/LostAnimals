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
  
  func dismissSelectPhotoPopupAndRemovePhoto() {
    DispatchQueue.main.async {
      self.viewController?.dismissCurrentView(completion: {
        NotificationCenter.default.post(name: .RemovePhotoFromSelectPhotoPopup, object: nil)
      })
    }
  }
  
  func dismissSelectPhotoPopupAndChooseFromLibrary() {
    DispatchQueue.main.async {
      self.viewController?.dismissCurrentView(completion: {
        NotificationCenter.default.post(name: .ChooseFromLibraryFromSelectPhotoPopup, object: nil)
      })
    }
  }
  
  func dismissSelectPhotoPopupAndTakeAPhoto() {
    DispatchQueue.main.async {
      self.viewController?.dismissCurrentView(completion: {
        NotificationCenter.default.post(name: .TakeAPhotoFromSelectPhotoPopup, object: nil)
      })
    }
  }
}
