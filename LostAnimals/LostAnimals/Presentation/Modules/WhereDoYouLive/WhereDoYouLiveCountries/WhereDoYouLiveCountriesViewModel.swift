//
//  WhereDoYouLiveCountriesViewModel.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 10/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import Foundation

final class WhereDoYouLiveCountriesViewModel {
  
  // MARK: - Properties
  private let router: WhereDoYouLiveCountriesRouter
  var countries: [Country] = []
  
  // MARK: - Init
  required init(router: WhereDoYouLiveCountriesRouter) {
    self.router = router
  }
  
}

// MARK: - Life cycle
extension WhereDoYouLiveCountriesViewModel {
  func viewReady() {
    // Called when view is loaded and ready
  }
  
  func viewDidAppear() {
    
  }
}

// MARK: - Functions
extension WhereDoYouLiveCountriesViewModel {
  func getCountriesFromCountriesJson(completion: () -> Void) {
    guard let path = Bundle.main.path(forResource: "Countries", ofType: "json") else { return }
    let url = URL(fileURLWithPath: path)
    do {
      let jsonData = try Data(contentsOf: url, options: .mappedIfSafe)
      let countriesDTO = try JSONDecoder().decode([CountryDTO].self, from: jsonData)
      let countries = countriesDTO.compactMap({$0.map()})
      self.countries = countries
      completion()
    } catch { print(error) }
  }
  
  func didPressCountryCell(cities: [String]) {
    self.router.goToWhereDoYouLiveCities(cities: cities)
  }
}
