//
//  SignUpProtocols.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 9/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import Foundation
import MapKit

// MARK: - SignUpStepsDelegate
extension SignUpViewController: SignUpStepsDelegate {
    func moveToNextSignUpStep() {
        moveToNextStep()
    }
    
    func moveToPreviousSignUpStep() {
        moveToPreviousStep()
    }
    
    func goToWhereDoYouLiveCountries(comesFrom: WhereDoYouLiveComesFrom) {
        goToWhereDoYouLive(comesFrom: comesFrom)
    }
    
    func goToWhereCanWeFindYou() {
        goToWhereCanWeFindYouAddress()
    }
    
    func goToTermsAndConditions() {
        goToTermsAndConditionsVC()
    }
    
    func updateSignUpUserInteraction(isUserInteractionEnabled: Bool) {
        navigationController?.navigationBar.isUserInteractionEnabled = isUserInteractionEnabled
        navigationController?.interactivePopGestureRecognizer?.isEnabled = isUserInteractionEnabled
    }
    
    func sendSignUpStep1Data(isAnimalShelter: Bool, firstname: String, lastname: String, birthdate: String?, location: Location) {
        viewModel.user.animalShelter = isAnimalShelter
        viewModel.user.firstname = firstname
        viewModel.user.lastname = lastname
        viewModel.user.birthdate = birthdate
        viewModel.user.location = location
    }
    
    func sendSignUpStep2Data(mail: String, password: String) {
        viewModel.user.email = mail
        viewModel.userPassword = password
    }
    
    func sendSignUpStep3Data(phonePrefix: String, phoneNumber: String, whatsapp: String?, instagram: String?, twitter: String?) {
        viewModel.user.socialMedias[.phonePrefix] = phonePrefix
        viewModel.user.socialMedias[.phoneNumber] = phoneNumber
        viewModel.user.socialMedias[.whatsapp] = whatsapp
        viewModel.user.socialMedias[.instagram] = instagram
        viewModel.user.socialMedias[.twitter] = twitter
    }
}

// MARK: - WhereDoYouLiveCountriesDelegate
extension SignUpViewController: WhereDoYouLiveCountriesDelegate {
    func getDialCode(dialCode: String) {
        fillPhonePrefixOfSocialMediaDetails(dialCode: dialCode)
    }
}

// MARK: - WhereCanWeFindYouDelegate
extension SignUpViewController: WhereCanWeFindYouDelegate {
    func getWhereCanWeFindYou(whereCanWeFindYouSearchResult: MKLocalSearchCompletion) {
        fillWhereCanWeFindYouPersonalDetails(whereCanWeFindYouSearchResult: whereCanWeFindYouSearchResult)
    }
}
