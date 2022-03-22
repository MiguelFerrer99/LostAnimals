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
    var animalFilterDog: Bool
    var animalFilterBird: Bool
    var animalFilterCat: Bool
    var animalFilterTurtle: Bool
    var animalFilterSnake: Bool
    var animalFilterRabbit: Bool
    var animalFilterOther: Bool
    var locationFilterRangeKm: Int?
    var dateFilterDatesBeforeOf: Date?
    var dateFilterDatesAfterOf: Date?
}
