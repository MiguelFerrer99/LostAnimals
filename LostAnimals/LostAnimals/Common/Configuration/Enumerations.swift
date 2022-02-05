//
//  Enumerations.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 9/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import Foundation

enum SignUpStep: Int {
    case personalDetails
    case accountDetails
    case socialMediaDetails
}

enum SignUpStepLabel: String {
    case personalDetails = "Personal details"
    case accountDetails = "Account details"
    case socialMediaDetails = "Social media details"
}

enum MoveDirection: Int {
    case back
    case next
}

enum WhereDoYouLiveComesFrom: String {
    case personalDetails
    case socialMediaDetails
}

enum WhereCanWeFindYouComesFrom: String {
    case signUp
    case editPost
    case newPost
}

enum OnboardingStep: Int {
    case share
    case find
    case contact
}

enum TabBarItem: Int {
    case explore
    case newPost
    case profile
}

enum PostType: String {
    case lost = "Lost"
    case found = "Found"
    case adopt = "Adopt"
}

enum AnimalType: String {
    case dog = "Dog"
    case bird = "Bird"
    case cat = "Cat"
    case turtle = "Turtle"
    case snake = "Snake"
    case rabbit = "Rabbit"
    case other = "Other"
}

enum FilterType: Int {
    case all
    case lost
    case found
    case adopt
    case animal
    case location
    case date
}

enum PostComesFrom: String {
    case explore
    case profile
}

enum AnimalTypesComesFrom: String {
    case editPost
    case newPost
}

enum SelectPhotoPopupComesFrom: String {
    case editPost
    case newPost
    case profileSettings
}

enum BannedPopupComesFrom: String {
    case login
    case tabbar
}

enum ProfileSectionType: String {
    case posts
    case savedPosts
    case socialMedias
}

enum SocialMediaType: String {
    case email
    case phone
    case whatsapp
    case instagram
    case twitter
}

enum ProfileSettingsImageType: String {
    case header
    case user
}
