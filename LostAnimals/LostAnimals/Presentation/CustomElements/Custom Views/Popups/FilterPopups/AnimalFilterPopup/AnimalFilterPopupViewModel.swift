//
//  AnimalFilterPopupViewModel.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 2/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import Foundation

final class AnimalFilterPopupViewModel {
  
  // MARK: - Properties
  private let router: AnimalFilterPopupRouter
  var selectedAnimalTypes: [AnimalType] = []
  
  // MARK: - Init
  required init(router: AnimalFilterPopupRouter) {
    self.router = router
  }
}

// MARK: - Life cycle
extension AnimalFilterPopupViewModel {
  func viewReady() {
    // Called when view is loaded and ready
  }
  
  func viewDidAppear() {
    
  }
}

// MARK: - Functions
extension AnimalFilterPopupViewModel {
  func didPressApplyFilterButton() {
    Filters.setFilterValue(filterType: .all, enabled: false)
    selectedAnimalTypes.forEach { selectedAnimalType in
      Filters.setFilterValue(filterType: .animal, enabled: true,
                             animalFilterDog: selectedAnimalType == .dog,
                             animalFilterBird: selectedAnimalType == .bird,
                             animalFilterCat: selectedAnimalType == .cat,
                             animalFilterTurtle: selectedAnimalType == .turtle,
                             animalFilterSnake: selectedAnimalType == .snake,
                             animalFilterRabbit: selectedAnimalType == .rabbit,
                             animalFilterOther: selectedAnimalType == .other)
    }
    NotificationCenter.default.post(name: .UpdateFiltersUI, object: nil)
    self.router.dismissAnimalFilterPopup()
  }
  
  func didPressDismissButton() {
    self.router.dismissAnimalFilterPopup()
  }
}
