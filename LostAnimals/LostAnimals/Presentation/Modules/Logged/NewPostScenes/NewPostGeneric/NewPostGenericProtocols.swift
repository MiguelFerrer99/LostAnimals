//
//  NewPostGenericProtocols.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 10/2/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import Foundation
import MapKit

// MARK: - ActionAfterSelectPhotoDelegate
extension NewPostGenericViewController: ActionAfterSelectPhotoDelegate {
    func goTo(action: ActionAfterSelectPhoto) {
        switch action {
        case .removePhoto: removePhoto()
        case .choosePhoto: choosePhoto()
        case .takePhoto:   takePhoto()
        }
    }
}

// MARK: - AnimalTypesDelegate
extension NewPostGenericViewController: AnimalTypesDelegate {
    func getAnimalType(animalType: AnimalType) {
        fillAnimal(animalType: animalType)
    }
}

// MARK: - WhereCanWeFindYouDelegate
extension NewPostGenericViewController: WhereCanWeFindYouDelegate {
    func getWhereCanWeFindYou(whereCanWeFindYouSearchResult: MKLocalSearchCompletion) {
        fillWhereCanWeFindYou(searchResult: whereCanWeFindYouSearchResult)
    }
    
    func getWhereCanWeFindYou(addressString: String) {
        fillWhereCanWeFindYou(addressString: addressString)
    }
}
