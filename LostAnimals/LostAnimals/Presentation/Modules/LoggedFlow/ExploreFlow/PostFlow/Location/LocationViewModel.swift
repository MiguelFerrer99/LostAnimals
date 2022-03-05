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
    let animal: Animal?
    let userFirstName: String?
    
    // MARK: - Init
    required init(router: LocationRouter, coordinates: Coordinates, animal: Animal? = nil, userFirstName: String? = nil) {
        self.router = router
        self.coordinates = coordinates
        self.animal = animal
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
        if let animal = animal {
            if let animalName = animal.name {
                mapItem.name = animalName
            } else {
                mapItem.name = "Found animal"
            }
        } else if let userFirstName = userFirstName {
            mapItem.name = userFirstName
        }
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
    }
}
