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
  static var currentExploreFilters: [ExploreFilterType: PostsFilter] = [
    .all: PostsFilter(filterTitle: "All", filterType: .all, enabled: true),
    .lost: PostsFilter(filterTitle: "Lost", filterType: .lost, enabled: false),
    .found: PostsFilter(filterTitle: "Found", filterType: .found, enabled: false),
    .adopt: PostsFilter(filterTitle: "Adopt", filterType: .adopt, enabled: false),
    .animal: PostsFilter(filterTitle: "Animal", filterType: .animal, enabled: false),
    .location: PostsFilter(filterTitle: "Location", filterType: .location, enabled: false),
    .date: PostsFilter(filterTitle: "Date", filterType: .date, enabled: false)
  ] {
    didSet {
      printCurrentExploreFilterValues()
    }
  }
  
  // MARK: - Functions
  static func setExploreFilterValue(exploreFilterType: ExploreFilterType, enabled: Bool) {
    currentExploreFilters[exploreFilterType]?.enabled = enabled
  }
  
  static func getFilter(from position: Int) -> PostsFilter? {
    if let exploreFilterType = ExploreFilterType(rawValue: position), let exploreFilter = Filters.currentExploreFilters[exploreFilterType] {
      return exploreFilter
    }
    return nil
  }
  
  static func resetFilters() {
    currentExploreFilters[.all]?.enabled = true
    currentExploreFilters[.lost]?.enabled = false
    currentExploreFilters[.found]?.enabled = false
    currentExploreFilters[.adopt]?.enabled = false
    currentExploreFilters[.animal]?.enabled = false
    currentExploreFilters[.location]?.enabled = false
    currentExploreFilters[.date]?.enabled = false
  }
  
  static func printCurrentExploreFilterValues() {
    print("FILTER VALUES:")
    currentExploreFilters.forEach { currentExploreFilter in
      print("  \(currentExploreFilter.value.filterTitle) = \(currentExploreFilter.value.enabled)")
    }
  }
}
