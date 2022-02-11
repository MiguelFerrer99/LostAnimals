//
//  EditSocialMediasProtocols.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 10/2/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import Foundation

extension EditSocialMediasViewController: WhereDoYouLiveCountriesDelegate {
    // MARK: - WhereDoYouLiveCountriesDelegate
    func getDialCode(dialCode: String) {
        fillPhonePrefix(dialCode: dialCode)
    }
}
