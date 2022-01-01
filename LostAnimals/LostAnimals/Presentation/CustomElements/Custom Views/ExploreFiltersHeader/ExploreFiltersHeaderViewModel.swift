//
//  ExploreFiltersHeaderViewModel.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 31/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

class ExploreFiltersHeaderViewModel: ViewModel {
  // MARK: - Properties
  var filters = [
    ExploreFiltersCollectionViewCellSummary(filterTitle: ExploreFilterType.all.rawValue, filterType: .all),
    ExploreFiltersCollectionViewCellSummary(filterTitle: ExploreFilterType.lost.rawValue, filterType: .lost),
    ExploreFiltersCollectionViewCellSummary(filterTitle: ExploreFilterType.found.rawValue, filterType: .found),
    ExploreFiltersCollectionViewCellSummary(filterTitle: ExploreFilterType.adopt.rawValue, filterType: .adopt),
    ExploreFiltersCollectionViewCellSummary(filterTitle: ExploreFilterType.animal.rawValue, filterType: .animal),
    ExploreFiltersCollectionViewCellSummary(filterTitle: ExploreFilterType.location.rawValue, filterType: .location),
    ExploreFiltersCollectionViewCellSummary(filterTitle: ExploreFilterType.date.rawValue, filterType: .date)
  ]
  
  // MARK: - Init
  init() {}
}
