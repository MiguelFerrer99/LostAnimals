//
//  Enumerations.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 9/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import Foundation

public enum SignUpStep: Int {
  case personalDetails
  case accountDetails
  case socialMediaDetails
}

public enum SignUpStepLabel: String {
  case personalDetails = "Personal details"
  case accountDetails = "Account details"
  case socialMediaDetails = "Social media details"
}

public enum MoveDirection: Int {
  case back
  case next
}

public enum WhereDoYouLiveComesFrom: String {
  case personalDetails
  case socialMediaDetails
}

public enum WhereCanWeFindYouComesFrom: String {
  case signUp
  case editPost
  case newPost
}

public enum OnboardingStep: Int {
  case share
  case find
  case contact
}

public enum TabBarItem: Int {
  case explore
  case newPost
  case profile
}

public enum PostType: String {
  case lost = "Lost"
  case found = "Found"
  case adopt = "Adopt"
}

public enum AnimalType: String {
  case dog = "Dog"
  case bird = "Bird"
  case cat = "Cat"
  case turtle = "Turtle"
  case snake = "Snake"
  case rabbit = "Rabbit"
  case other = "Other"
}

public enum FilterType: Int {
  case all
  case lost
  case found
  case adopt
  case animal
  case location
  case date
}

public enum PostComesFrom: String {
  case explore
  case profile
}

public enum AnimalTypesComesFrom: String {
  case editPost
  case newPost
}

public enum SelectPhotoPopupComesFrom: String {
  case editPost
  case newPost
}

public enum BannedPopupComesFrom: String {
  case login
  case tabbar
}
