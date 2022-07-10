//
//  WhereCanWeFindYouViewModel.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 19/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import Foundation
import MapKit

// MARK: - Enums
enum WhereCanWeFindYouComesFrom: String {
    case signUp
    case editPost
    case newPost
    case editPersonalDetails
}

final class WhereCanWeFindYouViewModel {
    // MARK: - Properties
    private let router: WhereCanWeFindYouRouter
    var searchResults = [MKLocalSearchCompletion]()
    let comesFrom: WhereCanWeFindYouComesFrom
    var locationConfigured = false
    
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
        self.router.goBack(comesFrom: comesFrom, searchResult: searchResult)
    }
    
    func didPressAddress(addressString: String, coordinates: Coordinates) {
        self.router.goBack(addressString: addressString, coordinates: coordinates)
    }
}
