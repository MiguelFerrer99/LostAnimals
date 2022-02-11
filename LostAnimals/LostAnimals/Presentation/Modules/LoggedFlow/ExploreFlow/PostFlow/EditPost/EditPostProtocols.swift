//
//  EditPostProtocols.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 10/2/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import Foundation
import UIKit
import MapKit

extension EditPostViewController: ActionAfterSelectPhotoDelegate, AnimalTypesDelegate, WhereCanWeFindYouDelegate {
    // MARK: - ActionAfterSelectPhotoDelegate
    func goTo(action: ActionAfterSelectPhoto) {
        switch action {
        case .removePhoto: removePhoto()
        case .choosePhoto: choosePhoto()
        case .takePhoto:   takePhoto()
        }
    }
    
    // MARK: - AnimalTypesDelegate
    func getAnimalType(animalType: AnimalType) {
        fillAnimal(animalType: animalType)
    }
    
    // MARK: - WhereCanWeFindYouDelegate
    func getWhereCanWeFindYou(whereCanWeFindYouSearchResult: MKLocalSearchCompletion) {
        fillWhereCanWeFindYou(searchResult: whereCanWeFindYouSearchResult)
    }
}
