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
    var collectionSections: [ProfileSectionType] = [.posts]
    let user: User
    let isMyProfile: Bool
    var isBlocked: Bool
    var socialMediaTypes: [SocialMediaType] = []
    
    // MARK: - Init
    required init(router: ProfileRouter, user: User) {
        self.router = router
        self.user = user
        self.isMyProfile = user == User.shared
        self.isBlocked = User.shared?.blockedUsers.contains(user.id) ?? false
        if user.socialMedias[.email] != nil { self.socialMediaTypes.append(.email) }
        if user.socialMedias[.phone] != nil { self.socialMediaTypes.append(.phone) }
        if user.socialMedias[.whatsapp] != nil { self.socialMediaTypes.append(.whatsapp) }
        if user.socialMedias[.instagram] != nil { self.socialMediaTypes.append(.instagram) }
        if user.socialMedias[.twitter] != nil { self.socialMediaTypes.append(.twitter) }
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
        isBlocked.toggle()
        if isBlocked {
            showSuccessPopup(title: "The user has been blocked successfully", action: allowed(true))
        } else {
            allowed(true)
        }
    }
    
    func didPressSettingsButton() {
        self.router.goToProfileSettings()
    }
    
    func didPressLocation() {
        guard let coordinates = user.location.coordinates else { return }
        self.router.goToLocation(coordinates: coordinates, userFirstName: user.firstname)
    }
    
    func didPressPost(post: Post) {
        self.router.goToPost(post: post)
    }
    
    func didPressPhoneButton() {
        self.router.contactByPhone(fullPhoneNumber: user.socialMedias[.phone])
    }
    
    func didPressWhatsappButton() {
        self.router.contactByWhatsapp(fullPhoneNumber: user.socialMedias[.phone])
    }
    
    func didPressInstagramButton() {
        self.router.contactByInstagram(instagram: user.socialMedias[.instagram])
    }
    
    func didPressTwitterButton() {
        self.router.contactByTwitter(twitter: user.socialMedias[.twitter])
    }
    
    func didPressFirstCollectionHeaderButton() {
        self.router.goToProfilePosts(user: user)
    }
    
    func didPressSecondCollectionHeaderButton() {
        if isMyProfile {
            self.router.goToMySavedPosts()
        }
    }
}
