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
  let user: User
  let isMyProfile: Bool
  
  // MARK: - Init
  required init(router: ProfileRouter, user: User) {
    self.router = router
    self.user = user
    self.isMyProfile = user == User.shared
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
  func didPressBackButton() {
    self.router.goBack()
  }
  
  func didPressLogoutButton() {
    Cache.logOut()
    self.router.changeRootToStartup()
  }
  
  func didPressBlockUserButton() {
    // TODO: Block user and change UI
  }
}
