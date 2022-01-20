//
//  ProfileViewModel.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 30/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import Foundation

final class ProfileViewModel {
  
  // MARK: - Properties
  private let router: ProfileRouter
  let isMyProfile: Bool
  
  // MARK: - Init
  required init(router: ProfileRouter, isMyProfile: Bool) {
    self.router = router
    self.isMyProfile = isMyProfile
  }
}

// MARK: - Life cycle
extension ProfileViewModel {
  func viewReady() {
    // Called when view is loaded and ready
  }
  
  func viewDidAppear() {
    // Called when view has appeared
  }
}

// MARK: - Functions
extension ProfileViewModel {
  func didPressLogoutButton() {
    Cache.logOut()
    self.router.changeRootToStartup()
  }
}
