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
  private let router: WhereCanWeFindYouRouter
  var searchResults = [MKLocalSearchCompletion]()
  let comesFrom: WhereCanWeFindYouComesFrom
  
  // MARK: - Init
  required init(router: WhereCanWeFindYouRouter, comesFrom: WhereCanWeFindYouComesFrom) {
    self.router = router
    self.comesFrom = comesFrom
  }
}

// MARK: - Life cycle
extension WhereCanWeFindYouViewModel {
  func viewReady() {
    // Called when view is loaded and ready
  }
  
  func viewDidAppear() {
    // Called when view has appeared
  }
}

// MARK: - Functions
extension WhereCanWeFindYouViewModel {
  func didPressAddress(searchResult: MKLocalSearchCompletion) {
    let userInfo: [String: MKLocalSearchCompletion] = ["searchResult": searchResult]
    switch comesFrom {
    case .signUp:
      NotificationCenter.default.post(name: .SendWhereCanWeFindYouAddressToSignUp, object: nil, userInfo: userInfo)
    case .editPost:
      NotificationCenter.default.post(name: .SendWhereCanWeFindYouAddressToEditPost, object: nil, userInfo: userInfo)
    case .newPost:
      NotificationCenter.default.post(name: .SendWhereCanWeFindYouAddressToNewPost, object: nil, userInfo: userInfo)
    }
    self.router.goBack()
  }
}
