//
//  NotificationName.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 20/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import Foundation

extension Notification.Name {
  static let SendWhereDoYouLiveCountryAndCities = Notification.Name("SendWhereDoYouLiveCountryAndCities")
  static let SendWhereCanWeFindYouAddressToSignUp = Notification.Name("SendWhereCanWeFindYouAddressToSignUp")
  static let SendWhereCanWeFindYouAddressToEditPost = Notification.Name("SendWhereCanWeFindYouAddressToEditPost")
  static let SendCountryDialCode = Notification.Name("SendCountryDialCode")
  static let SendAnimalToEditPost = Notification.Name("SendAnimalToEditPost")
  
  static let UpdateFiltersUI = Notification.Name("UpdateFiltersUI")
  
  static let GoToEditPostFromPostOptionsPopup = Notification.Name("GoToEditPostFromPostOptionsPopup")
  static let RemovePhotoFromSelectPhotoPopup = Notification.Name("RemovePhotoFromSelectPhotoPopup")
  static let ChooseFromLibraryFromSelectPhotoPopup = Notification.Name("ChooseFromLibraryFromSelectPhotoPopup")
  static let TakeAPhotoFromSelectPhotoPopup = Notification.Name("TakeAPhotoFromSelectPhotoPopup")
  
  static let ShowGuestPopupFromPostOptionsPopup = Notification.Name("ShowGuestPopupFromPostOptionsPopup")
  static let ShowSuccessPopupFromPostOptionsPopup = Notification.Name("ShowSuccessPopupFromPostOptionsPopup")
  static let ShowErrorPopupFromPostOptionsPopup = Notification.Name("ShowErrorPopupFromPostOptionsPopup")
  static let ShowActivityViewControllerFromPostOptionsPopup = Notification.Name("ShowActivityViewControllerFromPostOptionsPopup")
}
