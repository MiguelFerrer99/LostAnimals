//
//  Constants.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 28/10/2021.
//  Copyright © 2020 Miguel Ferrer Fornali. All rights reserved.
//

import Foundation
import UIKit

let onboardingStepsInfo = [
  OnboardingStepInfo(title: "Share",
                     description: "Have you lost your pet? We help you to find her by sharing information. Everyone stay tuned! 👀",
                     image: UIImage(named: "OnboardingItem1") ?? UIImage()),
  OnboardingStepInfo(title: "Find",
                     description: "Have you seen an abandoned pet? Share it so everyone knows where and when have you seen it 🔍",
                     image: UIImage(named: "OnboardingItem2") ?? UIImage()),
  OnboardingStepInfo(title: "Contact",
                     description: "Contact people easily through their social networks to solve everything 📞",
                     image: UIImage(named: "OnboardingItem3") ?? UIImage())
]

let termsAndConditions = [
  TermAndCondition(title: "Term 1", description: "jkfnasdkjfbasdjhlfbasdjfhbsdlfhjbasdfjlbasdfljhbasdljhbsadfjlhasdbfaljshdbfasldjhbf"),
  TermAndCondition(title: "Term 2", description: "jkfnasdkjfbasdjhlfbasdjfhbsdlfhjbasdfjlbasdfljhbasdljhbsadfjlhasdbfaljshdbfasldjhbf"),
  TermAndCondition(title: "Term 3", description: "jkfnasdkjfbasdjhlfbasdjfhbsdlfhjbasdfjlbasdfljhbasdljhbsadfjlhasdbfaljshdbfasldjhbf"),
  TermAndCondition(title: "Term 4", description: "jkfnasdkjfbasdjhlfbasdjfhbsdlfhjbasdfjlbasdfljhbasdljhbsadfjlhasdbfaljshdbfasldjhbf"),
  TermAndCondition(title: "Term 5", description: "jkfnasdkjfbasdjhlfbasdjfhbsdlfhjbasdfjlbasdfljhbasdljhbsadfjlhasdbfaljshdbfasldjhbf"),
  TermAndCondition(title: "Term 6", description: "jkfnasdkjfbasdjhlfbasdjfhbsdlfhjbasdfjlbasdfljhbasdljhbsadfjlhasdbfaljshdbfasldjhbf"),
  TermAndCondition(title: "Term 7", description: "jkfnasdkjfbasdjhlfbasdjfhbsdlfhjbasdfjlbasdfljhbasdljhbsadfjlhasdbfaljshdbfasldjhbf"),
  TermAndCondition(title: "Term 8", description: "jkfnasdkjfbasdjhlfbasdjfhbsdlfhjbasdfjlbasdfljhbasdljhbsadfjlhasdbfaljshdbfasldjhbf"),
  TermAndCondition(title: "Term 9", description: "jkfnasdkjfbasdjhlfbasdjfhbsdlfhjbasdfjlbasdfljhbasdljhbsadfjlhasdbfaljshdbfasldjhbf"),
  TermAndCondition(title: "Term 10", description: "jkfnasdkjfbasdjhlfbasdjfhbsdlfhjbasdfjlbasdfljhbasdljhbsadfjlhasdbfaljshdbfasldjhbf"),
  TermAndCondition(title: "Term 11", description: "jkfnasdkjfbasdjhlfbasdjfhbsdlfhjbasdfjlbasdfljhbasdljhbsadfjlhasdbfaljshdbfasldjhbf"),
  TermAndCondition(title: "Term 12", description: "jkfnasdkjfbasdjhlfbasdjfhbsdlfhjbasdfjlbasdfljhbasdljhbsadfjlhasdbfaljshdbfasldjhbf"),
  TermAndCondition(title: "Term 13", description: "jkfnasdkjfbasdjhlfbasdjfhbsdlfhjbasdfjlbasdfljhbasdljhbsadfjlhasdbfaljshdbfasldjhbf")
]

var currentExploreFilters = [
  PostsFilter(filterTitle: ExploreFilterType.all.rawValue, filterType: .all, enabled: true),
  PostsFilter(filterTitle: ExploreFilterType.lost.rawValue, filterType: .lost, enabled: false),
  PostsFilter(filterTitle: ExploreFilterType.found.rawValue, filterType: .found, enabled: false),
  PostsFilter(filterTitle: ExploreFilterType.adopt.rawValue, filterType: .adopt, enabled: false),
  PostsFilter(filterTitle: ExploreFilterType.animal.rawValue, filterType: .animal, enabled: false),
  PostsFilter(filterTitle: ExploreFilterType.location.rawValue, filterType: .location, enabled: false),
  PostsFilter(filterTitle: ExploreFilterType.date.rawValue, filterType: .date, enabled: false)
]
