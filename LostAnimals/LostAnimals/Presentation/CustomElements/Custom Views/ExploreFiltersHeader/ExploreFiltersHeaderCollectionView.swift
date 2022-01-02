//
//  ExploreFiltersHeaderCollectionView.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 31/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

extension ExploreFiltersHeader: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func configureCollectionView(_ collectionView: UICollectionView) {
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.allowsMultipleSelection = true
    collectionView.register(ExploreFiltersCollectionViewCell.self)
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return Filters.currentExploreFilters.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let currentExploreFilter = Filters.currentExploreFilters[ExploreFilterType(rawValue: indexPath.row) ?? .all] else { return UICollectionViewCell() }
    let summary = ExploreFiltersCollectionViewCellSummary(filterTitle: currentExploreFilter.filterTitle, filterType: currentExploreFilter.filterType)
    let cell = collectionView.dequeue(ExploreFiltersCollectionViewCell.self, for: indexPath)
    cell.display(summary: summary)
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 90, height: collectionView.frame.height)
  }
  
  func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
    guard let unselectedFilter = Filters.getFilter(from: indexPath.row) else { return false }
    if unselectedFilter.filterType == .all {
      deselectFilters()
      Filters.setExploreFilterValue(exploreFilterType: .all, enabled: true)
      return true
    } else {
      deselectFilter(type: .all)
      Filters.setExploreFilterValue(exploreFilterType: unselectedFilter.filterType, enabled: true)
      postFiltersDelegate?.showPostFiltersDelegate(filterType: unselectedFilter.filterType)
      return true
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
    guard let selectedFilter = Filters.getFilter(from: indexPath.row), let selectedFilters = collectionView.indexPathsForSelectedItems else { return false }
    if selectedFilter.filterType == .all {
      return false
    } else if selectedFilters.count == 1 {
      selectFilter(type: .all)
      Filters.setExploreFilterValue(exploreFilterType: selectedFilter.filterType, enabled: false)
      return true
    } else if selectedFilters.count > 1 {
      Filters.setExploreFilterValue(exploreFilterType: selectedFilter.filterType, enabled: false)
      return true
    }
    return false
  }
}
