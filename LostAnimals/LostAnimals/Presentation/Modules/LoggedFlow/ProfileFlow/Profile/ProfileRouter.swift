//
//  ProfileRouter.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 30/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

final class ProfileRouter {
    // MARK: - Properties
    private weak var viewController: ProfileViewController?
    
    // MARK: - Init
    required init(viewController: ProfileViewController?) {
        self.viewController = viewController
    }
}

// MARK: - Functions
extension ProfileRouter {
    func goBack() {
        self.viewController?.pop()
    }
    
    func goToProfileSettings(profileImages: ProfileImages) {
        DispatchQueue.main.async {
            guard let me = User.shared else { return }
            let viewController = Container.shared.profileSettingsBuilder().build(me: me, profileImages: profileImages)
            viewController.delegate = self.viewController
            self.viewController?.push(viewController: viewController)
        }
    }
    
    func goToLocation(coordinates: Coordinates, userFirstName: String? = nil) {
        DispatchQueue.main.async {
            let viewController = Container.shared.locationBuilder().build(coordinates: coordinates, userFirstName: userFirstName)
            self.viewController?.push(viewController: viewController)
        }
    }
    
    func changeRootToStartup() {
        DispatchQueue.main.async {
            let viewController = Container.shared.startupBuilder().build().embeddedInNavigation()
            changeRoot(to: viewController)
        }
    }
    
    func goToPost(post: Post) {
        DispatchQueue.main.async {
            let viewController = Container.shared.postBuilder().build(comesFrom: .profile, post: post)
            self.viewController?.push(viewController: viewController)
        }
    }
    
    func contactByPhone(fullPhoneNumber: String?) {
        if let fullPhoneNumber = fullPhoneNumber {
            if let numberURL = URL(string: "tel://" + fullPhoneNumber), UIApplication.shared.canOpenURL(numberURL) {
                UIApplication.shared.open(numberURL)
            } else {
                showErrorPopup(title: .ServiceErrors.OpenPhone(), action: nil)
            }
        }
    }
    
    func contactByWhatsapp(fullPhoneNumber: String?) {
        if let fullPhoneNumber = fullPhoneNumber {
            if let appURL = URL(string: "whatsapp://send?phone=\(fullPhoneNumber)"), UIApplication.shared.canOpenURL(appURL) {
                UIApplication.shared.open(appURL)
            } else if let appStoreURL = URL(string: "itms-apps://itunes.apple.com/app/apple-store/id310633997?mt=8"), UIApplication.shared.canOpenURL(appStoreURL) {
                UIApplication.shared.open(appStoreURL)
            } else {
                showErrorPopup(title: .ServiceErrors.OpenWhatsapp(), action: nil)
            }
        }
    }
    
    func contactByInstagram(instagram: String?) {
        if let instagram = instagram {
            if let appURL = URL(string: "instagram://user?username=\(instagram)"), UIApplication.shared.canOpenURL(appURL) {
                UIApplication.shared.open(appURL)
            } else if let webURL = URL(string: "https://instagram.com/\(instagram)"), UIApplication.shared.canOpenURL(webURL) {
                UIApplication.shared.open(webURL)
            } else {
                showErrorPopup(title: .ServiceErrors.OpenInstagram(), action: nil)
            }
        }
    }
    
    func contactByTwitter(twitter: String?) {
        if let twitter = twitter {
            if let appURL = URL(string: "twitter://user?screen_name=\(twitter)"), UIApplication.shared.canOpenURL(appURL) {
                UIApplication.shared.open(appURL)
            } else if let webURL = URL(string: "https://twitter.com/\(twitter)"), UIApplication.shared.canOpenURL(webURL) {
                UIApplication.shared.open(webURL)
            } else {
                showErrorPopup(title: .ServiceErrors.OpenTwitter(), action: nil)
            }
        }
    }
    
    func goToMySavedPosts() {
        DispatchQueue.main.async {
            let viewController = Container.shared.savedPostsBuilder().build(comesFrom: .profile)
            self.viewController?.push(viewController: viewController)
        }
    }
    
    func goToProfilePosts(isMyProfile: Bool, posts: [Post]) {
        DispatchQueue.main.async {
            let viewController = Container.shared.profilePostsBuilder().build(isMyProfile: isMyProfile, posts: posts)
            self.viewController?.push(viewController: viewController)
        }
    }
    
    func goToPostImages(image: UIImage) {
        DispatchQueue.main.async {
            let viewController = Container.shared.postImagesBuilder().build(postImages: [image], indexPostImage: 0)
            self.viewController?.present(viewController: viewController)
        }
    }
}
