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
    let country: Country
    var cities: [String]
    var filteredCities: [String]
    
    // MARK: - Init
    required init(router: WhereDoYouLiveCitiesRouter, country: Country, cities: [String]) {
        self.router = router
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
        
    }
}

// MARK: - Functions
extension WhereDoYouLiveCitiesViewModel {
    func getWhereDoYouLiveFromCountryAndCity(country: Country, city: String) -> String {
        let whereDoYouLiveString = "\(city), \(country.nameEN)"
        return whereDoYouLiveString
    }
    
    func didPressCity(city: String) {
        let whereDoYouLiveString = "\(city), \(country.nameEN)"
        let userInfo: [String: String] = ["whereDoYouLiveString": whereDoYouLiveString]
        NotificationCenter.default.post(name: .SendWhereDoYouLiveCountryAndCities, object: nil, userInfo: userInfo)
        self.router.goToSignUp()
    }
}
