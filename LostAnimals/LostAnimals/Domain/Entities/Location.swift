//
//  Location.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 4/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

struct Location: Codable, Equatable {
    // MARK: - Properties
    let address: String
    let coordinates: Coordinates?
    
    // MARK: - Functions
    static func == (lhs: Location, rhs: Location) -> Bool {
        return (lhs.address == rhs.address) && (lhs.coordinates == rhs.coordinates)
    }
}
