//
//  LocationViewModel.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 7/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import MapKit

final class LocationViewModel {
    // MARK: - Properties
    private let router: LocationRouter
    let coordinates: Coordinates
    let animalName: String?
    let userFirstName: String?
    
    // MARK: - Init
    required init(router: LocationRouter, coordinates: Coordinates, animalName: String? = nil, userFirstName: String? = nil) {
        self.router = router
        self.coordinates = coordinates
        self.animalName = animalName
        self.userFirstName = userFirstName
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
        let coordinate = CLLocationCoordinate2DMake(coordinates.latitude, coordinates.longitude)
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary: nil))
        if let userFirstName = userFirstName {
            mapItem.name = userFirstName
        } else if let animalName = animalName {
            mapItem.name = animalName
        } else {
            mapItem.name = "Found animal"
        }
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
    }
}
