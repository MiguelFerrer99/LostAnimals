//
//  ContactWithPopupMailController.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 10/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit
import MessageUI

// MARK: - Functions
extension ContactWithPopupViewController {
    func configureMailController(mailController: MFMailComposeViewController) {
        mailController.mailComposeDelegate = self
    }
    
    func sendEmail(email: String?) {
        if let email = email {
            if MFMailComposeViewController.canSendMail() {
                mailController.setToRecipients([email])
                mailController.setSubject("LostAnimals")
                self.present(viewController: mailController, completion: nil)
            } else if let appStoreURL = URL(string: "itms-apps://itunes.apple.com/app/apple-store/id1108187098?mt=8"), UIApplication.shared.canOpenURL(appStoreURL) {
                UIApplication.shared.open(appStoreURL)
            } else {
                showErrorPopup(title: "Error opening Mail. Please, try again later", action: nil)
            }
        }
    }
}

// MARK: - MFMailComposeViewControllerDelegate
extension ContactWithPopupViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        if error != nil {
            controller.dismiss(animated: true) {
                showErrorPopup(title: "Error sending mail. Please, try again later", action: nil)
            }
        } else {
            switch result {
            case .sent:
                controller.dismiss(animated: true) {
                    showSuccessPopup(title: "The mail has been sent successfully", action: nil)
                }
            case .failed:
                controller.dismiss(animated: true) {
                    showErrorPopup(title: "Error sending mail. Please, try again later", action: nil)
                }
            default:
                controller.dismiss(animated: true, completion: nil)
            }
        }
    }
}
