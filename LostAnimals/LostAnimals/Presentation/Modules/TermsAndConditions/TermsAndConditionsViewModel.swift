//
//  TermsAndConditionsViewModel.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 28/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import Foundation

final class TermsAndConditionsViewModel {
  
  // MARK: - Properties
  private let router: TermsAndConditionsRouter
  let terms = [
    TermTableViewCellSummary(title: "Term 1", description: "jkfnasdkjfbasdjhlfbasdjfhbsdlfhjbasdfjlbasdfljhbasdljhbsadfjlhasdbfaljshdbfasldjhbf"),
    TermTableViewCellSummary(title: "Term 2", description: "jkfnasdkjfbasdjhlfbasdjfhbsdlfhjbasdfjlbasdfljhbasdljhbsadfjlhasdbfaljshdbfasldjhbf"),
    TermTableViewCellSummary(title: "Term 3", description: "jkfnasdkjfbasdjhlfbasdjfhbsdlfhjbasdfjlbasdfljhbasdljhbsadfjlhasdbfaljshdbfasldjhbf"),
    TermTableViewCellSummary(title: "Term 4", description: "jkfnasdkjfbasdjhlfbasdjfhbsdlfhjbasdfjlbasdfljhbasdljhbsadfjlhasdbfaljshdbfasldjhbf"),
    TermTableViewCellSummary(title: "Term 5", description: "jkfnasdkjfbasdjhlfbasdjfhbsdlfhjbasdfjlbasdfljhbasdljhbsadfjlhasdbfaljshdbfasldjhbf"),
    TermTableViewCellSummary(title: "Term 6", description: "jkfnasdkjfbasdjhlfbasdjfhbsdlfhjbasdfjlbasdfljhbasdljhbsadfjlhasdbfaljshdbfasldjhbf"),
    TermTableViewCellSummary(title: "Term 7", description: "jkfnasdkjfbasdjhlfbasdjfhbsdlfhjbasdfjlbasdfljhbasdljhbsadfjlhasdbfaljshdbfasldjhbf"),
    TermTableViewCellSummary(title: "Term 8", description: "jkfnasdkjfbasdjhlfbasdjfhbsdlfhjbasdfjlbasdfljhbasdljhbsadfjlhasdbfaljshdbfasldjhbf"),
    TermTableViewCellSummary(title: "Term 9", description: "jkfnasdkjfbasdjhlfbasdjfhbsdlfhjbasdfjlbasdfljhbasdljhbsadfjlhasdbfaljshdbfasldjhbf"),
    TermTableViewCellSummary(title: "Term 10", description: "jkfnasdkjfbasdjhlfbasdjfhbsdlfhjbasdfjlbasdfljhbasdljhbsadfjlhasdbfaljshdbfasldjhbf"),
    TermTableViewCellSummary(title: "Term 11", description: "jkfnasdkjfbasdjhlfbasdjfhbsdlfhjbasdfjlbasdfljhbasdljhbsadfjlhasdbfaljshdbfasldjhbf"),
    TermTableViewCellSummary(title: "Term 12", description: "jkfnasdkjfbasdjhlfbasdjfhbsdlfhjbasdfjlbasdfljhbasdljhbsadfjlhasdbfaljshdbfasldjhbf"),
    TermTableViewCellSummary(title: "Term 13", description: "jkfnasdkjfbasdjhlfbasdjfhbsdlfhjbasdfjlbasdfljhbasdljhbsadfjlhasdbfaljshdbfasldjhbf")
  ]
  
  // MARK: - Init
  required init(router: TermsAndConditionsRouter) {
    self.router = router
  }
  
}

// MARK: - Life cycle
extension TermsAndConditionsViewModel {
  func viewReady() {
    // Called when view is loaded and ready
  }
  
  func viewDidAppear() {
    
  }
}

// MARK: - Functions
extension TermsAndConditionsViewModel {
}
