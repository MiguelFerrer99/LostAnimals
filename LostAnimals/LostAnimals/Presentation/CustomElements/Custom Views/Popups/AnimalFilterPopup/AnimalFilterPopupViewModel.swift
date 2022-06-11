//
//  AnimalFilterPopupViewModel.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 2/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class AnimalFilterPopupViewModel {
    // MARK: - Properties
    private let router: AnimalFilterPopupRouter
    let loadData: Bool
    var selectedAnimalType: AnimalType?
    
    // MARK: - Init
    required init(router: AnimalFilterPopupRouter, loadData: Bool) {
        self.router = router
        self.loadData = loadData
    }
}

// MARK: - Life cycle
extension AnimalFilterPopupViewModel {
    func viewReady() {
        // Called when view is loaded and ready
    }
    
    func viewDidAppear() {
        // Called when view has appeared
    }
}

// MARK: - Functions
extension AnimalFilterPopupViewModel {
    func didPressApplyFilterButton() {
        Filters.setFilterValue(filterType: .animal, enabled: true, animalFiltered: selectedAnimalType)
        Filters.currentFilters[.animal]?.filterTitle = selectedAnimalType?.rawValue ?? "Animal"
        self.router.dismissAnimalFilterPopup()
    }
    
    func didPressDismissButton() {
        self.router.dismissAnimalFilterPopup()
    }
}
