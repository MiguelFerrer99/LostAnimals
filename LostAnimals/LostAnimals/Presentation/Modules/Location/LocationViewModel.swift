//
//  LocationViewModel.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 7/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import Foundation
import MapKit

final class LocationViewModel {
  
  // MARK: - Properties
  private let router: LocationRouter
  let location: Location
  let animal: Animal
  
  // MARK: - Init
  required init(router: LocationRouter, location: Location, animal: Animal) {
    self.router = router
    self.location = location
    self.animal = animal
  }
}

// MARK: - Life cycle
extension LocationViewModel {
  func viewReady() {
    // Called when view is loaded and ready
  }
  
  func viewDidAppear() {
    // Called when view has appeared
  }
}

// MARK: - Functions
extension LocationViewModel {
  func openLocationInMaps() {
    let coordinate = CLLocationCoordinate2DMake(location.lat, location.long)
    let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary: nil))
    mapItem.name = animal.name
    mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
  }
}
