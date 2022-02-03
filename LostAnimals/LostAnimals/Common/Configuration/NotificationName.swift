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
    static let SendWhereCanWeFindYouAddressToNewPost = Notification.Name("SendWhereCanWeFindYouAddressToNewPost")
    static let SendCountryDialCode = Notification.Name("SendCountryDialCode")
    static let SendAnimalToEditPost = Notification.Name("SendAnimalToEditPost")
    static let SendAnimalToNewPost = Notification.Name("SendAnimalToNewPost")
    
    static let UpdateFiltersUI = Notification.Name("UpdateFiltersUI")
    
    static let GoToEditPostFromPostOptionsPopup = Notification.Name("GoToEditPostFromPostOptionsPopup")
    static let RemovePhotoFromSelectPhotoPopupFromEditPost = Notification.Name("RemovePhotoFromSelectPhotoPopupFromEditPost")
    static let ChooseFromLibraryFromSelectPhotoPopupFromEditPost = Notification.Name("ChooseFromLibraryFromSelectPhotoPopupFromEditPost")
    static let TakeAPhotoFromSelectPhotoPopupFromEditPost = Notification.Name("TakeAPhotoFromSelectPhotoPopupFromEditPost")
    static let RemovePhotoFromSelectPhotoPopupFromNewPost = Notification.Name("RemovePhotoFromSelectPhotoPopupFromNewPost")
    static let ChooseFromLibraryFromSelectPhotoPopupFromNewPost = Notification.Name("ChooseFromLibraryFromSelectPhotoPopupFromNewPost")
    static let TakeAPhotoFromSelectPhotoPopupFromNewPost = Notification.Name("TakeAPhotoFromSelectPhotoPopupFromNewPost")
    static let RemovePhotoFromSelectPhotoPopupFromProfileSettings = Notification.Name("RemovePhotoFromSelectPhotoPopupFromProfileSettings")
    static let ChooseFromLibraryFromSelectPhotoPopupFromProfileSettings = Notification.Name("ChooseFromLibraryFromSelectPhotoPopupFromProfileSettings")
    static let TakeAPhotoFromSelectPhotoPopupFromProfileSettings = Notification.Name("TakeAPhotoFromSelectPhotoPopupFromProfileSettings")
    
    static let ShowGuestPopupFromPostOptionsPopup = Notification.Name("ShowGuestPopupFromPostOptionsPopup")
    static let ShowSuccessPopupFromPostOptionsPopup = Notification.Name("ShowSuccessPopupFromPostOptionsPopup")
    static let ShowErrorPopupFromPostOptionsPopup = Notification.Name("ShowErrorPopupFromPostOptionsPopup")
    static let ShowActivityViewControllerFromPostOptionsPopup = Notification.Name("ShowActivityViewControllerFromPostOptionsPopup")
}
