//
//  PostsFilter.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 1/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

struct PostsFilter {
    // MARK: - Properties
    var filterTitle: String
    let filterType: FilterType
    var enabled: Bool
    var animalFiltered: AnimalType?
}
