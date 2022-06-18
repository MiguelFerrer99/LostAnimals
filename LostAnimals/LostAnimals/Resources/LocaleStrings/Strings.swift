//
//  Strings.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 15/6/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

protocol Localizable: CustomStringConvertible {
    var rawValue: String { get }
}

extension Localizable {
    var localized: String {
        return NSLocalizedString(self.rawValue, comment: "")
    }

    var uppercased: String {
        return self.localized.uppercased()
    }

    var description: String {
        return self.localized
    }

    func localized(with: CVarArg...) -> String {
        let text = String(format: self.localized, arguments: with)
        return text
    }

    func callAsFunction() -> String {
        return self.localized
    }
}

extension String {
    enum Startup: String, Localizable {
        case WelcomeTitle = "Startup_WelcomeTitle"
        case WelcomeText = "Startup_WelcomeText"
        case ContinueAsGuest = "Startup_ContinueAsGuest"
        case LogIn = "Startup_LogIn"
        case SignUp = "Startup_SignUp"
    }
    enum Onboarding: String, Localizable {
        case Item1Title = "Onboarding_Item1Title"
        case Item1Text = "Onboarding_Item1Text"
        case Item2Title = "Onboarding_Item2Title"
        case Item2Text = "Onboarding_Item2Text"
        case Item3Title = "Onboarding_Item3Title"
        case Item3Text = "Onboarding_Item3Text"
    }
    enum LogIn: String, Localizable {
        case Title = "LogIn_Title"
        case Mail = "LogIn_Mail"
        case Password = "LogIn_Password"
        case ForgotPassword = "LogIn_ForgotPassword"
        case LogInButton = "LogIn_LogInButton"
    }
    enum ForgotPassword: String, Localizable {
        case Title = "ForgotPassword_Title"
        case Mail = "ForgotPassword_Mail"
        case Text = "ForgotPassword_Text"
        case RecoverPasswordButton = "ForgotPassword_RecoverPasswordButton"
    }
}
