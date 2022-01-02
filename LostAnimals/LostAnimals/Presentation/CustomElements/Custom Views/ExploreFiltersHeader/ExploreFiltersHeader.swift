//
//  ExploreFiltersHeader.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 31/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

class ExploreFiltersHeader: UICollectionReusableView, Reusable {
  
  // MARK: - IBOutlets
  @IBOutlet weak var filtersCollectionView: UICollectionView!
  
  // MARK: - Properties
  weak var postFiltersDelegate: PostFiltersDelegate?
  
  // MARK: - Life cycle
  override func awakeFromNib() {
    super.awakeFromNib()
    
    setupUI()
  }
  
  // MARK: - Functions
  private func setupUI() {
    preselectAllFilter()
    configureCollectionView(filtersCollectionView)
  }
  
  private func preselectAllFilter() {
    filtersCollectionView.performBatchUpdates(nil) { result in
      if result { self.filtersCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .left) }
    }
  }
  
  func selectFilter(type: ExploreFilterType) {
    filtersCollectionView.selectItem(at: IndexPath(item: type.rawValue, section: 0), animated: true, scrollPosition: .left)
    Filters.setExploreFilterValue(exploreFilterType: type, enabled: true)
  }
  
  func deselectFilter(type: ExploreFilterType) {
    filtersCollectionView.deselectItem(at: IndexPath(item: type.rawValue, section: 0), animated: true)
    Filters.setExploreFilterValue(exploreFilterType: type, enabled: false)
  }
  
  func deselectFilters() {
    Filters.currentExploreFilters.forEach { currentExploreFilter in
      filtersCollectionView.deselectItem(at: IndexPath(item: currentExploreFilter.key.rawValue, section: 0), animated: true)
      Filters.setExploreFilterValue(exploreFilterType: currentExploreFilter.key, enabled: false)
    }
  }
}
