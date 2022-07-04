//
//  ProfileViewModel.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 30/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import Foundation
import UIKit

final class ProfileViewModel {
    // MARK: - Properties
    private let router: ProfileRouter
    var user: User
    var isMyProfile: Bool
    var socialMediaTypes: [SocialMediaType] = []
    var posts: [Post] = []
    var savedPosts: [Post] = []
    var userImage: UIImage?
    var headerImage: UIImage?
    
    // MARK: - Services
    let userService = UserService()
    let postService = PostService()
    
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
    func getPosts(completion: @escaping (() -> Void)) {
        if isMyProfile {
            postService.getMyPosts { result in
                switch result {
                case .success(let posts):
                    self.posts = posts
                    completion()
                case .error(let error):
                    showErrorPopup(title: error)
                }
            }
        } else {
            postService.getPosts { result in
                switch result {
                case .success(let posts):
                    self.posts = posts
                    completion()
                case .error(let error):
                    showErrorPopup(title: error)
                }
            }
        }
    }
    
    func getSavedPosts(completion: @escaping (() -> Void)) {
        postService.getSavedPosts { result in
            switch result {
            case .success(let posts):
                self.savedPosts = posts
                completion()
            case .error(let error):
                showErrorPopup(title: error)
            }
        }
    }
    
    func getAge() -> Int? {
        guard let auxBirthdate = user.birthdate?.toDate(withFormat: DateFormat.dayMonthYearOther) else { return nil }
        let birthdate = DateComponents(year: auxBirthdate.year,
                                       month: auxBirthdate.month,
                                       day: auxBirthdate.day)
        let now = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        let ageComponents = Calendar.current.dateComponents([.year], from: birthdate, to: now)
        
        return ageComponents.year
    }
    
    func reloadPosts() {
        NotificationCenter.default.post(name: .UpdateSavedPosts, object: nil)
        NotificationCenter.default.post(name: .UpdateExplorePosts, object: nil)
    }
    
    func didPressBlockUserButton(isBlocked: @escaping ((Bool) -> ())) {
        if Cache.get(boolFor: .logged) {
            let isUserBlocked = User.shared?.blockedUsers.contains(user.id) ?? false
            let userFullName = user.lastname.isEmpty ? user.firstname : user.firstname + user.lastname
            if isUserBlocked {
                showConfirmationPopup(title: .Profile.AreYouSureUnblock.localized(with: userFullName)) {
                    self.userService.unblockUser(userID: self.user.id) { result in
                        switch result {
                        case .success:
                            self.reloadPosts()
                            isBlocked(false)
                        case .error(let error):
                            showErrorPopup(title: error)
                        }
                    }
                }
            } else {
                showConfirmationPopup(title: .Profile.AreYouSureBlock.localized(with: userFullName)) {
                    self.userService.blockUser(userID: self.user.id) { result in
                        switch result {
                        case .success:
                            self.reloadPosts()
                            isBlocked(true)
                        case .error(let error):
                            showErrorPopup(title: error)
                        }
                    }
                }
            }
        } else {
            showGuestPopup()
        }
    }
    
    func didPressBackButton() {
        self.router.goBack()
    }
    
    func didPressSettingsButton() {
        self.router.goToProfileSettings(profileImages: (userImage, headerImage))
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
        self.router.goToProfilePosts(isMyProfile: isMyProfile, posts: posts)
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
    
    func didPressMyPet() {
        self.router.goToMyPet(myPet: user.pet)
    }
}
