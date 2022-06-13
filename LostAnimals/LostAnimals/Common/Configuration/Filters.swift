//
//  Filters.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 2/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

// MARK: - Enums
enum FilterType: Int {
    case lost
    case found
    case adopt
    case animal
    case recent
    case near
}

class Filters {
    // MARK: - Properties
    static var currentFilters: [FilterType: PostsFilter] = [
        .lost: PostsFilter(filterTitle: "Lost", filterType: .lost, enabled: false),
        .found: PostsFilter(filterTitle: "Found", filterType: .found, enabled: false),
        .adopt: PostsFilter(filterTitle: "Adopt", filterType: .adopt, enabled: false),
        .animal: PostsFilter(filterTitle: "Animal", filterType: .animal, enabled: false),
        .near: PostsFilter(filterTitle: "Near", filterType: .near, enabled: false),
        .recent: PostsFilter(filterTitle: "Recent", filterType: .recent, enabled: true)
    ] {
        didSet {
            // printCurrentExploreFilterValues()
        }
    }
    
    // MARK: - Functions
    static func resetFilters() {
        currentFilters[.lost]?.enabled = false
        currentFilters[.found]?.enabled = false
        currentFilters[.adopt]?.enabled = false
        currentFilters[.animal]?.enabled = false
        currentFilters[.animal]?.filterTitle = "Animal"
        currentFilters[.recent]?.enabled = true
        currentFilters[.near]?.enabled = false
        currentFilters[.near]?.filterTitle = "Near"
    }
    
    static func printCurrentExploreFilterValues() {
        print("FILTER VALUES:")
        currentFilters.forEach { currentExploreFilter in
            print("  \(currentExploreFilter.value.filterTitle) = \(currentExploreFilter.value.enabled)")
        }
    }
}
