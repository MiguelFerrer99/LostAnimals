//
//  Coordinates.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 9/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

struct Coordinates: Codable {
    // MARK: - Properties
    let longitude: Double
    let latitude: Double
    
    // MARK: - Functions
    func areBetween(_ coordinate1: Coordinates, _ coordinate2: Coordinates) -> Bool {
        let longitudeIsBetweenThem = self.longitude.isBetween(coordinate1.longitude, coordinate2.longitude)
        let latitudeIsBetweenThem = self.latitude.isBetween(coordinate1.latitude, coordinate2.latitude)
        return longitudeIsBetweenThem && latitudeIsBetweenThem
    }
}
