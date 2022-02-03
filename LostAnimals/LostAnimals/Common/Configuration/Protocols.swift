//
//  Protocols.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 9/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import Foundation

protocol SignUpStepsDelegate: AnyObject {
    func moveToNextSignUpStep()
    func moveToPreviousSignUpStep()
    func goToWhereDoYouLiveCountries(comesFrom: WhereDoYouLiveComesFrom)
    func goToWhereCanWeFindYou()
    func goToTermsAndConditions()
    func updateSignUpUserInteraction(isUserInteractionEnabled: Bool)
    func sendSignUpStep1Data(isAnimalShelter: Bool, firstname: String?, lastname: String?, animalShelterName: String?, birthdate: Date?, location: Location)
    func sendSignUpStep2Data(mail: String, password: String)
    func sendSignUpStep3Data(fullPhone: String, whatsapp: String?, instagram: String?, twitter: String?)
}

protocol PostFiltersDelegate: AnyObject {
    func showPostFilters(filterType: FilterType)
}
