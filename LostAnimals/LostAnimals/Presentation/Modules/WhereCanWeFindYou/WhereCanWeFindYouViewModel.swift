//
//  WhereCanWeFindYouViewModel.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 19/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import Foundation
import MapKit

final class WhereCanWeFindYouViewModel {
  
  // MARK: - Properties
  var searchResults = [MKLocalSearchCompletion]()
  private let router: WhereCanWeFindYouRouter
  
  // MARK: - Init
  required init(router: WhereCanWeFindYouRouter) {
    self.router = router
  }

}

// MARK: - Life cycle
extension WhereCanWeFindYouViewModel {
  func viewReady() {
    // Called when view is loaded and ready
  }
  
  func viewDidAppear() {
    
  }
}

// MARK: - Functions
extension WhereCanWeFindYouViewModel {
  func didPressAddress(searchResult: MKLocalSearchCompletion) {
    let userInfo: [String: MKLocalSearchCompletion] = ["searchResult": searchResult]
    NotificationCenter.default.post(name: .SendWhereCanWeFindYouAddress, object: nil, userInfo: userInfo)
    self.router.goToSignUp()
  }
}
