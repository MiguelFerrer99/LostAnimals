//
//  WhereDoYouLiveCitiesViewModel.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 11/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import Foundation

final class WhereDoYouLiveCitiesViewModel {
  
  // MARK: - Properties
  private let router: WhereDoYouLiveCitiesRouter
  let cities: [String]
  
  // MARK: - Init
  required init(router: WhereDoYouLiveCitiesRouter, cities: [String]) {
    self.router = router
    self.cities = cities
  }
  
}

// MARK: - Life cycle
extension WhereDoYouLiveCitiesViewModel {
  func viewReady() {
    // Called when view is loaded and ready
  }
  
  func viewDidAppear() {
    
  }
}

// MARK: - Functions
extension WhereDoYouLiveCitiesViewModel {
}
