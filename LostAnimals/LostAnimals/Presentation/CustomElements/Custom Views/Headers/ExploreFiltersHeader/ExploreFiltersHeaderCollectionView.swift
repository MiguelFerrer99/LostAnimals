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
        return Filters.currentFilters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let currentExploreFilter = Filters.currentFilters[FilterType(rawValue: indexPath.row) ?? .all] else { return UICollectionViewCell() }
        let summary = ExploreFiltersCollectionViewCellSummary(filterTitle: currentExploreFilter.filterTitle, filterType: currentExploreFilter.filterType, index: indexPath.row)
        let cell = collectionView.dequeue(ExploreFiltersCollectionViewCell.self, for: indexPath)
        cell.display(summary: summary)
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0 || indexPath.row == Filters.currentFilters.count - 1 { return CGSize(width: 130, height: collectionView.frame.height) }
        else { return CGSize(width: 110, height: collectionView.frame.height) }
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        guard let unselectedFilter = Filters.getFilter(from: indexPath.row) else { return false }
        switch unselectedFilter.filterType {
        case .all:
            disableFilters()
        case .lost, .found, .adopt:
            Filters.setFilterValue(filterType: .all, enabled: false)
            Filters.setFilterValue(filterType: unselectedFilter.filterType, enabled: true)
            NotificationCenter.default.post(name: .UpdateFiltersUI, object: nil)
        case .animal, .location, .date:
            postFiltersDelegate?.showPostFilters(filterType: unselectedFilter.filterType, loadData: false)
        }
        return false
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        guard let selectedFilter = Filters.getFilter(from: indexPath.row) else { return false }
        switch selectedFilter.filterType {
        case .all, .lost, .found, .adopt:
            return false
        case .animal, .location, .date:
            postFiltersDelegate?.showPostFilters(filterType: selectedFilter.filterType, loadData: true)
        }
        return false
    }
}
