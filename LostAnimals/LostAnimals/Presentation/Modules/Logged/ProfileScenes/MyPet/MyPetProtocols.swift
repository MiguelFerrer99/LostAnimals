//
//  MyPetProtocols.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 4/7/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import Foundation

// MARK: - ActionAfterSelectPhotoDelegate
extension MyPetViewController: ActionAfterSelectPhotoDelegate {
    func goTo(action: ActionAfterSelectPhoto) {
        switch action {
        case .removePhoto: removePhoto()
        case .choosePhoto: choosePhoto()
        case .takePhoto:   takePhoto()
        }
    }
}

// MARK: - AnimalTypesDelegate
extension MyPetViewController: AnimalTypesDelegate {
    func getAnimalType(animalType: AnimalType) {
        fillAnimal(animalType: animalType)
    }
}
