//
//  ContactWithPopupRouter.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 7/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class ContactWithPopupRouter {
    // MARK: - Properties
    private weak var viewController: ContactWithPopupViewController?
    
    // MARK: - Init
    required init(viewController: ContactWithPopupViewController?) {
        self.viewController = viewController
    }
}

// MARK: - Functions
extension ContactWithPopupRouter {
    func dismissContactWithPopup() {
        self.viewController?.dismissCurrentView(completion: nil)
    }
    
    func contactByPhone(fullPhoneNumber: String?) {
        if let fullPhoneNumber = fullPhoneNumber {
            if let numberURL = URL(string: "tel://\(fullPhoneNumber)"), UIApplication.shared.canOpenURL(numberURL) {
                UIApplication.shared.open(numberURL)
            } else {
                showErrorPopup(title: "Error opening Phone. Please, try again later", action: nil)
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
                showErrorPopup(title: "Error opening WhatsApp. Please, try again later", action: nil)
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
                showErrorPopup(title: "Error opening instagram profile. Please, try again later", action: nil)
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
                showErrorPopup(title: "Error opening twitter profile. Please, try again later", action: nil)
            }
        }
    }
}
