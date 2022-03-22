//
//  Int.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 28/10/2021.
//  Copyright © 2020 Miguel Ferrer Fornali. All rights reserved.
//

extension Int {
    // MARK: - Properties
    var asMinutesToHourString: String {
        let hours = self / 60
        let minutes = self % 60
        return String(format:"%02ih %02imin", hours, minutes)
    }
}
