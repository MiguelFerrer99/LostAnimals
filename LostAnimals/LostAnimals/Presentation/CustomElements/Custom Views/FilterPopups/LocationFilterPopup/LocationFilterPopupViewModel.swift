//
//  LocationFilterPopupViewModel.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 3/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import Foundation

final class LocationFilterPopupViewModel {
  
  // MARK: - Properties
  private let router: LocationFilterPopupRouter
  var selectedRangeOfKm: Int = 2
  
  // MARK: - Init
  required init(router: LocationFilterPopupRouter) {
    self.router = router
  }
}

// MARK: - Life cycle
extension LocationFilterPopupViewModel {
  func viewReady() {
    // Called when view is loaded and ready
  }
  
  func viewDidAppear() {
    
  }
}

// MARK: - Functions
extension LocationFilterPopupViewModel {
  func didPressApplyFilterButton() {
    Filters.setFilterValue(filterType: .all, enabled: false)
    Filters.setFilterValue(filterType: .location, enabled: true, locationFilterRangeKm: selectedRangeOfKm)
    NotificationCenter.default.post(name: .UpdateFiltersUI, object: nil)
    self.router.dismissLocationFilterPopup()
  }
  
  func didPressDismissButton() {
    self.router.dismissLocationFilterPopup()
  }
}
