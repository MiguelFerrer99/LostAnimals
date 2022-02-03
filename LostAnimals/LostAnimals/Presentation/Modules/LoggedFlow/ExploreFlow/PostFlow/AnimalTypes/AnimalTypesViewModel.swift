//
//  AnimalTypesViewModel.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 5/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import Foundation

final class AnimalTypesViewModel {
    
    // MARK: - Properties
    private let router: AnimalTypesRouter
    let comesFrom: AnimalTypesComesFrom
    var selectedAnimalType: AnimalType?
    
    // MARK: - Init
    required init(router: AnimalTypesRouter, comesFrom: AnimalTypesComesFrom) {
        self.router = router
        self.comesFrom = comesFrom
    }
}

// MARK: - Life cycle
extension AnimalTypesViewModel {
    func viewReady() {
        // Called when view is loaded and ready
    }
    
    func viewDidAppear() {
        // Called when view has appeared
    }
}

// MARK: - Functions
extension AnimalTypesViewModel {
    func didSelectedAnimalType() {
        let userInfo: [String: AnimalType] = ["animalType": selectedAnimalType ?? .other]
        switch comesFrom {
        case .editPost:
            NotificationCenter.default.post(name: .SendAnimalToEditPost, object: nil, userInfo: userInfo)
        case .newPost:
            NotificationCenter.default.post(name: .SendAnimalToNewPost, object: nil, userInfo: userInfo)
        }
        self.router.goBack()
    }
}
