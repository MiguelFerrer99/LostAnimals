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
  let coordinates: Coordinates
  let animal: Animal
  
  // MARK: - Init
  required init(router: LocationRouter, coordinates: Coordinates, animal: Animal) {
    self.router = router
    self.coordinates = coordinates
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
    let coordinate = CLLocationCoordinate2DMake(coordinates.lat, coordinates.long)
    let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary: nil))
    mapItem.name = animal.name
    mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
  }
}
