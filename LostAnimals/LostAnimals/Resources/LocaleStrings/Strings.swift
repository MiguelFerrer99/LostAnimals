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
}
