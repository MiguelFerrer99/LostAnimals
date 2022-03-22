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
    private let comesFrom: WhereDoYouLiveComesFrom
    let country: Country
    var cities: [String]
    var filteredCities: [String]
    
    // MARK: - Init
    required init(router: WhereDoYouLiveCitiesRouter, comesFrom: WhereDoYouLiveComesFrom, country: Country, cities: [String]) {
        self.router = router
        self.comesFrom = comesFrom
        self.country = country
        self.cities = cities
        self.filteredCities = self.cities
    }
}

// MARK: - Life cycle
extension WhereDoYouLiveCitiesViewModel {
    func viewReady() {
        // Called when view is loaded and ready
    }
    
    func viewDidAppear() {
        // Called when view has appeared
    }
}

// MARK: - Functions
extension WhereDoYouLiveCitiesViewModel {
    func getWhereDoYouLiveFromCountryAndCity(country: Country, city: String) -> String {
        let whereDoYouLiveString = "\(city), \(country.nameEN)"
        return whereDoYouLiveString
    }
    
    func didPressCity(city: String) {
        let whereDoYouLive = "\(city), \(country.nameEN)"
        switch comesFrom {
        case .signUpPersonalDetails,
             .signUpSocialMediaDetails:
            self.router.goToSignUp(whereDoYouLive: whereDoYouLive)
        case .editPersonalDetails:
            self.router.goToEditPersonalDetails(whereDoYouLive: whereDoYouLive)
        case .editSocialMediaDetails:
            return
        }
    }
}
