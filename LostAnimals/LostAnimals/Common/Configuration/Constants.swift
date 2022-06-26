//
//  Constants.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 28/10/2021.
//  Copyright © 2020 Miguel Ferrer Fornali. All rights reserved.
//

import UIKit

// MARK: - Constants
struct Constants {
    // MARK: - Properties
    static let emptyUser = User(id: "",
                                email: "",
                                animalShelter: false,
                                firstname: "",
                                lastname: "",
                                birthdate: Date().toString(withFormat: DateFormat.dayMonthYearOther),
                                userURLImage: nil,
                                headerURLImage: nil,
                                location: Location(address: .Commons.NotSpecifiedFemale(), coordinates: nil),
                                socialMedias: [:],
                                banned: false,
                                blockedUsers: [],
                                savedPosts: [])
    
    static let onboardingStepsInfo = [
        OnboardingStepInfo(title: .Onboarding.Item1Title(),
                           description: .Onboarding.Item1Text(),
                           image: UIImage(named: "OnboardingItem1") ?? UIImage()),
        OnboardingStepInfo(title: .Onboarding.Item2Title(),
                           description: .Onboarding.Item2Text(),
                           image: UIImage(named: "OnboardingItem2") ?? UIImage()),
        OnboardingStepInfo(title: .Onboarding.Item3Title(),
                           description: .Onboarding.Item3Text(),
                           image: UIImage(named: "OnboardingItem3") ?? UIImage())
    ]
    
    static let termsAndConditions = [
        TermAndCondition(title: .TermsAndConditions.Item1Title(), description: .TermsAndConditions.Item1Description()),
        TermAndCondition(title: .TermsAndConditions.Item2Title(), description: .TermsAndConditions.Item2Description()),
        TermAndCondition(title: .TermsAndConditions.Item3Title(), description: .TermsAndConditions.Item3Description()),
        TermAndCondition(title: .TermsAndConditions.Item4Title(), description: .TermsAndConditions.Item4Description()),
        TermAndCondition(title: .TermsAndConditions.Item5Title(), description: .TermsAndConditions.Item5Description()),
        TermAndCondition(title: .TermsAndConditions.Item6Title(), description: .TermsAndConditions.Item6Description()),
        TermAndCondition(title: .TermsAndConditions.Item7Title(), description: .TermsAndConditions.Item7Description()),
        TermAndCondition(title: .TermsAndConditions.Item8Title(), description: .TermsAndConditions.Item8Description()),
        TermAndCondition(title: .TermsAndConditions.Item9Title(), description: .TermsAndConditions.Item9Description()),
        TermAndCondition(title: .TermsAndConditions.Item10Title(), description: .TermsAndConditions.Item10Description()),
        TermAndCondition(title: .TermsAndConditions.Item11Title(), description: .TermsAndConditions.Item11Description()),
        TermAndCondition(title: .TermsAndConditions.Item12Title(), description: .TermsAndConditions.Item12Description())
    ]
    
    static let animalTypes: [AnimalType] = [
        .dog,
        .bird,
        .cat,
        .turtle,
        .snake,
        .rabbit,
        .other
    ]
    
    static let animalTypesNames: [String] = [
        .Commons.AnimalTypeDog(),
        .Commons.AnimalTypeBird(),
        .Commons.AnimalTypeCat(),
        .Commons.AnimalTypeTurtle(),
        .Commons.AnimalTypeSnake(),
        .Commons.AnimalTypeRabbit(),
        .Commons.AnimalTypeOther()
    ]
}
