//
//  Coordinates.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 9/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

struct Coordinates: Codable, Equatable {
    // MARK: - Properties
    let longitude: Double
    let latitude: Double
    
    // MARK: - Functions
    static func == (lhs: Coordinates, rhs: Coordinates) -> Bool {
        return (lhs.longitude == rhs.longitude) && (lhs.latitude == rhs.latitude)
    }
}
