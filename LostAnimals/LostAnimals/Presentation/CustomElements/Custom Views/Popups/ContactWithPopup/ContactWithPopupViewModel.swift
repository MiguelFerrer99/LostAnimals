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
  
  // MARK: - Init
  required init(router: ContactWithPopupRouter) {
    self.router = router
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
  
  func didPressMailButton() {
    self.router.contactByMail()
  }
  
  func didPressPhoneButton() {
    self.router.contactByPhone()
  }
  
  func didPressWhatsappButton() {
    self.router.contactByWhatsapp()
  }
  
  func didPressInstagramButton() {
    self.router.contactByInstagram()
  }
  
  func didPressTwitterButton() {
    self.router.contactByTwitter()
  }
}
