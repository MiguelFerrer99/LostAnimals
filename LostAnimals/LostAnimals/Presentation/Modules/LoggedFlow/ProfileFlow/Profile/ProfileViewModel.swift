//
//  ProfileViewModel.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 30/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Enums
enum ProfileSectionType: String {
    case posts
    case savedPosts
    case socialMedias
}

final class ProfileViewModel {
    // MARK: - Properties
    private let router: ProfileRouter
    var collectionSections: [ProfileSectionType] = [.posts]
    let user: User
    let isMyProfile: Bool
    var socialMediaTypes: [SocialMediaType] = []
    
    // MARK: - Init
    required init(router: ProfileRouter, user: User) {
        self.router = router
        self.user = user
        self.isMyProfile = user == User.shared
        if user.socialMedias[.email] != nil { self.socialMediaTypes.append(.email) }
        if user.socialMedias[.phonePrefix] != nil && user.socialMedias[.phoneNumber] != nil { self.socialMediaTypes.append(.phoneNumber) }
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
        guard let auxBirthdate = user.birthdate?.toDate(withFormat: DateFormat.dayMonthYearOther) else { return nil }
        let birthdate = DateComponents(year: auxBirthdate.year,
                                       month: auxBirthdate.month,
                                       day: auxBirthdate.day)
        let now = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        let ageComponents = Calendar.current.dateComponents([.year], from: birthdate, to: now)
        
        return ageComponents.year
    }
    
    func didPressBackButton() {
        self.router.goBack()
    }
    
    func didPressBlockUserButton(isBlocked: @escaping ((Bool) -> ())) {
        let isUserBlocked = User.shared?.blockedUsers.contains(user.id) ?? false
        let userFullName = user.lastname.isEmpty ? user.firstname : user.firstname + user.lastname
        if isUserBlocked {
            showConfirmationPopup(title: "Are you sure you want to unblock \(userFullName)?") {
                isBlocked(false)
            }
        } else {
            showConfirmationPopup(title: "Are you sure you want to block \(userFullName)?") {
                isBlocked(true)
            }
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
        guard let phonePrefix = user.socialMedias[.phonePrefix], let phoneNumber = user.socialMedias[.phoneNumber] else { return }
        let fullPhoneNumber = "+\(phonePrefix)\(phoneNumber)"
        self.router.contactByPhone(fullPhoneNumber: fullPhoneNumber)
    }
    
    func didPressWhatsappButton() {
        guard let phonePrefix = user.socialMedias[.phonePrefix], let phoneNumber = user.socialMedias[.phoneNumber] else { return }
        let fullPhoneNumber = "+\(phonePrefix)\(phoneNumber)"
        self.router.contactByWhatsapp(fullPhoneNumber: fullPhoneNumber)
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
    
    func didPressHeaderImage(headerImage: UIImage) {
        self.router.goToPostImages(image: headerImage)
    }
    
    func didPressUserImage(userImage: UIImage) {
        self.router.goToPostImages(image: userImage)
    }
}
