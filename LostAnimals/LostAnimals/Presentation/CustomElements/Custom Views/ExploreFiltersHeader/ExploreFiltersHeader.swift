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
    
    NotificationCenter.default.addObserver(self, selector: #selector(updateFiltersUI), name: .UpdateFiltersUI, object: nil)
    
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
  
  func selectFilter(type: FilterType) {
    filtersCollectionView.selectItem(at: IndexPath(item: type.rawValue, section: 0), animated: true, scrollPosition: .left)
    Filters.setFilterValue(filterType: type, enabled: true)
  }
  
  func deselectFilter(type: FilterType) {
    filtersCollectionView.deselectItem(at: IndexPath(item: type.rawValue, section: 0), animated: true)
    Filters.setFilterValue(filterType: type, enabled: false)
  }
  
  func deselectFilters() {
    Filters.currentFilters.forEach { currentExploreFilter in
      filtersCollectionView.deselectItem(at: IndexPath(item: currentExploreFilter.key.rawValue, section: 0), animated: true)
      Filters.setFilterValue(filterType: currentExploreFilter.key, enabled: false)
    }
  }
  
  @objc private func updateFiltersUI() {
    Filters.currentFilters.forEach { currentFilter in
      if currentFilter.value.enabled {
        selectFilter(type: currentFilter.key)
      } else {
        deselectFilter(type: currentFilter.key)
      }
    }
  }
}
