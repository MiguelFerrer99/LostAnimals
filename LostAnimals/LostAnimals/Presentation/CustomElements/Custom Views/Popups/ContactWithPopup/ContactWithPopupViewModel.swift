//
//  ContactWithPopupViewModel.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 7/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import Foundation

final class ContactWithPopupViewModel {
  
  // MARK: - Properties
  private let router: ContactWithPopupRouter
  let authorSocialMedias: SocialMedias
  
  // MARK: - Init
  required init(router: ContactWithPopupRouter, authorSocialMedias: SocialMedias) {
    self.router = router
    self.authorSocialMedias = authorSocialMedias
  }
}

// MARK: - Life cycle
extension ContactWithPopupViewModel {
  func viewReady() {
    // Called when view is loaded and ready
  }
  
  func viewDidAppear() {
    // Called when view has appeared
  }
}

// MARK: - Functions
extension ContactWithPopupViewModel {
  func dismissButtonPressed() {
    self.router.dismissContactWithPopup()
  }
  
  func didPressPhoneButton() {
    self.router.contactByPhone(prefixNumber: authorSocialMedias.phonePrefix, phoneNumber: authorSocialMedias.phoneNumber)
  }
  
  func didPressWhatsappButton() {
    self.router.contactByWhatsapp(prefixNumber: authorSocialMedias.phonePrefix, phoneNumber: authorSocialMedias.phoneNumber)
  }
  
  func didPressInstagramButton() {
    self.router.contactByInstagram(instagram: authorSocialMedias.instagram)
  }
  
  func didPressTwitterButton() {
    self.router.contactByTwitter(twitter: authorSocialMedias.twitter)
  }
}
