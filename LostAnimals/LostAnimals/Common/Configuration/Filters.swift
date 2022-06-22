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
    case recent
    case near
    case lost
    case found
    case adopt
    case animal
}

class Filters {
    // MARK: - Properties
    static var currentFilters: [FilterType: PostsFilter] = [
        .recent: PostsFilter(filterTitle: .Explore.RecentFilterTitle(), filterType: .recent, enabled: true),
        .near: PostsFilter(filterTitle: .Explore.NearFilterTitle(), filterType: .near, enabled: false),
        .lost: PostsFilter(filterTitle: .Explore.LostFilterTitle(), filterType: .lost, enabled: false),
        .found: PostsFilter(filterTitle: .Explore.FoundFilterTitle(), filterType: .found, enabled: false),
        .adopt: PostsFilter(filterTitle: .Explore.AdoptFilterTitle(), filterType: .adopt, enabled: false),
        .animal: PostsFilter(filterTitle: .Explore.AnimalFilterTitle(), filterType: .animal, enabled: false)
    ]
    
    // MARK: - Functions
    static func resetFilters() {
        currentFilters[.recent]?.enabled = false
        currentFilters[.near]?.enabled = false
        currentFilters[.lost]?.enabled = false
        currentFilters[.found]?.enabled = false
        currentFilters[.adopt]?.enabled = false
        currentFilters[.animal]?.enabled = false
        currentFilters[.animal]?.filterTitle = .Explore.AnimalFilterTitle()
    }
}
