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
        Filters.resetFilters()
        Filters.currentFilters[.animal]?.enabled = true
        Filters.currentFilters[.animal]?.animalFiltered = selectedAnimalType
        var animalFilterName: String = .Explore.AnimalFilterTitle()
        switch selectedAnimalType {
        case .dog:    animalFilterName = .Commons.AnimalTypeDog()
        case .cat:    animalFilterName = .Commons.AnimalTypeCat()
        case .bird:   animalFilterName = .Commons.AnimalTypeBird()
        case .rabbit: animalFilterName = .Commons.AnimalTypeRabbit()
        case .snake:  animalFilterName = .Commons.AnimalTypeSnake()
        case .turtle: animalFilterName = .Commons.AnimalTypeTurtle()
        case .other:  animalFilterName = .Commons.AnimalTypeOther()
        default:      animalFilterName = .Explore.AnimalFilterTitle()
        }
        Filters.currentFilters[.animal]?.filterTitle = animalFilterName
        self.router.applyFilterAndDismissAnimalFilterPopup(animalTypeName: animalFilterName)
    }
    
    func didPressDismissButton() {
        self.router.dismissAnimalFilterPopup()
    }
}
