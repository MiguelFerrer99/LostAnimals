//
//  ContactWithPopupViewModel.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 7/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

final class ContactWithPopupViewModel {
    // MARK: - Properties
    private let router: ContactWithPopupRouter
    let authorSocialMedias:  [SocialMediaType: String]
    
    // MARK: - Init
    required init(router: ContactWithPopupRouter, authorSocialMedias: [SocialMediaType: String]) {
        self.router = router
        self.authorSocialMedias = authorSocialMedias
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
    
    func didPressPhoneButton() {
        guard let phonePrefix = authorSocialMedias[.phonePrefix], let phoneNumber = authorSocialMedias[.phoneNumber] else { return }
        let fullPhoneNumber = "+\(phonePrefix)\(phoneNumber)"
        self.router.contactByPhone(fullPhoneNumber: fullPhoneNumber)
    }
    
    func didPressWhatsappButton() {
        self.router.contactByWhatsapp(fullPhoneNumber: authorSocialMedias[.whatsapp])
    }
    
    func didPressInstagramButton() {
        self.router.contactByInstagram(instagram: authorSocialMedias[.instagram])
    }
    
    func didPressTwitterButton() {
        self.router.contactByTwitter(twitter: authorSocialMedias[.twitter])
    }
}
