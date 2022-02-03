//
//  Filters.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 2/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import Foundation
import UIKit

struct Filters {
    static var currentFilters: [FilterType: PostsFilter] = [
        .all: PostsFilter(filterTitle: "All", filterType: .all, enabled: true, animalFilterDog: false, animalFilterBird: false, animalFilterCat: false, animalFilterTurtle: false, animalFilterSnake: false, animalFilterRabbit: false, animalFilterOther: false),
        .lost: PostsFilter(filterTitle: "Lost", filterType: .lost, enabled: false, animalFilterDog: false, animalFilterBird: false, animalFilterCat: false, animalFilterTurtle: false, animalFilterSnake: false, animalFilterRabbit: false, animalFilterOther: false),
        .found: PostsFilter(filterTitle: "Found", filterType: .found, enabled: false, animalFilterDog: false, animalFilterBird: false, animalFilterCat: false, animalFilterTurtle: false, animalFilterSnake: false, animalFilterRabbit: false, animalFilterOther: false),
        .adopt: PostsFilter(filterTitle: "Adopt", filterType: .adopt, enabled: false, animalFilterDog: false, animalFilterBird: false, animalFilterCat: false, animalFilterTurtle: false, animalFilterSnake: false, animalFilterRabbit: false, animalFilterOther: false),
        .animal: PostsFilter(filterTitle: "Animal", filterType: .animal, enabled: false, animalFilterDog: false, animalFilterBird: false, animalFilterCat: false, animalFilterTurtle: false, animalFilterSnake: false, animalFilterRabbit: false, animalFilterOther: false),
        .location: PostsFilter(filterTitle: "Location", filterType: .location, enabled: false, animalFilterDog: false, animalFilterBird: false, animalFilterCat: false, animalFilterTurtle: false, animalFilterSnake: false, animalFilterRabbit: false, animalFilterOther: false),
        .date: PostsFilter(filterTitle: "Date", filterType: .date, enabled: false, animalFilterDog: false, animalFilterBird: false, animalFilterCat: false, animalFilterTurtle: false, animalFilterSnake: false, animalFilterRabbit: false, animalFilterOther: false)
    ] {
        didSet { /*printCurrentExploreFilterValues()*/ }
    }
    
    // MARK: - Functions
    static func setFilterValue(filterType: FilterType, enabled: Bool, animalFilterDog: Bool? = nil, animalFilterBird: Bool? = nil, animalFilterCat: Bool? = nil, animalFilterTurtle: Bool? = nil, animalFilterSnake: Bool? = nil, animalFilterRabbit: Bool? = nil, animalFilterOther: Bool? = nil, locationFilterRangeKm: Int? = nil, dateFilterDatesBeforeOf: Date? = nil, dateFilterDatesAfterOf: Date? = nil) {
        currentFilters[filterType]?.enabled = enabled
        if let animalFilterDog = animalFilterDog { currentFilters[filterType]?.animalFilterDog = animalFilterDog }
        if let animalFilterBird = animalFilterBird { currentFilters[filterType]?.animalFilterBird = animalFilterBird }
        if let animalFilterCat = animalFilterCat { currentFilters[filterType]?.animalFilterCat = animalFilterCat }
        if let animalFilterTurtle = animalFilterTurtle { currentFilters[filterType]?.animalFilterTurtle = animalFilterTurtle }
        if let animalFilterSnake = animalFilterSnake { currentFilters[filterType]?.animalFilterSnake = animalFilterSnake }
        if let animalFilterRabbit = animalFilterRabbit { currentFilters[filterType]?.animalFilterRabbit = animalFilterRabbit }
        if let animalFilterOther = animalFilterOther { currentFilters[filterType]?.animalFilterOther = animalFilterOther }
    }
    
    static func getFilter(from position: Int) -> PostsFilter? {
        if let filterType = FilterType(rawValue: position), let filter = Filters.currentFilters[filterType] {
            return filter
        }
        return nil
    }
    
    static func resetFilters() {
        currentFilters[.all]?.enabled = true
        currentFilters[.lost]?.enabled = false
        currentFilters[.found]?.enabled = false
        currentFilters[.adopt]?.enabled = false
        currentFilters[.animal]?.enabled = false
        currentFilters[.animal]?.animalFilterDog = false
        currentFilters[.animal]?.animalFilterBird = false
        currentFilters[.animal]?.animalFilterCat = false
        currentFilters[.animal]?.animalFilterTurtle = false
        currentFilters[.animal]?.animalFilterSnake = false
        currentFilters[.animal]?.animalFilterRabbit = false
        currentFilters[.animal]?.animalFilterOther = false
        currentFilters[.location]?.enabled = false
        currentFilters[.location]?.locationFilterRangeKm = nil
        currentFilters[.date]?.enabled = false
        currentFilters[.date]?.dateFilterDatesBeforeOf = nil
        currentFilters[.date]?.dateFilterDatesAfterOf = nil
    }
    
    static func printCurrentExploreFilterValues() {
        print("FILTER VALUES:")
        currentFilters.forEach { currentExploreFilter in
            print("  \(currentExploreFilter.value.filterTitle) = \(currentExploreFilter.value.enabled)")
        }
    }
}
