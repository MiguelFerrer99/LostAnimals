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
  func getAge() -> Int? {
    let birthdate = DateComponents(year: user.birthdate.year,
                                   month: user.birthdate.month,
                                   day: user.birthdate.day)
    let now = Calendar.current.dateComponents([.year, .month, .day], from: Date())
    let ageComponents = Calendar.current.dateComponents([.year], from: birthdate, to: now)
    
    return ageComponents.year
  }
  
  func didPressBackButton() {
    self.router.goBack()
  }
  
  func didPressBlockUserButton(allowed: ((Bool) -> ())) {
    showSuccessPopup(title: "The user has been blocked successfully", action: allowed(true))
  }
  
  func didPressSettingsButton() {
    self.router.goToProfileSettings()
  }
  
  func didPressLocation() {
    guard let coordinates = user.location.coordinates else { return }
    self.router.goToLocation(coordinates: coordinates, userFirstName: user.firstname)
  }
  
  func didPressLogoutButton() {
    Cache.logOut()
    self.router.changeRootToStartup()
  }
}
