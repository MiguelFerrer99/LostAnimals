//
//  ExploreFiltersHeader.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 31/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

protocol PostFiltersDelegate: AnyObject {
    func showPostFilters(filterType: FilterType)
}

class ExploreFiltersHeader: UICollectionReusableView, Reusable {
    
    // MARK: - IBOutlets
    @IBOutlet weak var filtersCollectionView: UICollectionView!
    
    // MARK: - Properties
    weak var postFiltersDelegate: PostFiltersDelegate?
    
    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        subscribeToNotifications()
        setupUI()
    }
    
    deinit {
        unsubscribeToNotifications()
    }
    
    // MARK: - Functions
    private func subscribeToNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateFiltersUI), name: .UpdateFiltersUI, object: nil)
    }
    
    private func unsubscribeToNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setupUI() {
        preselectAllFilter()
        configureCollectionView(filtersCollectionView)
    }
    
    private func preselectAllFilter() {
        filtersCollectionView.performBatchUpdates(nil) { result in
            if result { self.filtersCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .left) }
        }
    }
    
    private func selectFilter(type: FilterType) {
        let indexPath = IndexPath(item: type.rawValue, section: 0)
        filtersCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
    }
    
    private func deselectFilter(type: FilterType) {
        let indexPath = IndexPath(item: type.rawValue, section: 0)
        filtersCollectionView.deselectItem(at: indexPath, animated: true)
    }
    
    func showDisableFilterButton(index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        guard let filterCell = filtersCollectionView.cellForItem(at: indexPath) as? ExploreFiltersCollectionViewCell else { return }
        filterCell.showDisableFilterButton()
    }
    
    func hideDisableFilterButton(index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        guard let filterCell = filtersCollectionView.cellForItem(at: indexPath) as? ExploreFiltersCollectionViewCell else { return }
        filterCell.hideDisableFilterButton()
    }
    
    func disableFilters() {
        Filters.currentFilters.forEach { currentExploreFilter in
            Filters.setFilterValue(filterType: currentExploreFilter.key, enabled: false)
        }
    }
    
    @objc private func updateFiltersUI() {
        Filters.currentFilters.forEach { currentFilter in
            if currentFilter.value.enabled {
                selectFilter(type: currentFilter.key)
                if currentFilter.key != .all { showDisableFilterButton(index: currentFilter.key.rawValue) }
            } else {
                deselectFilter(type: currentFilter.key)
                hideDisableFilterButton(index: currentFilter.key.rawValue)
            }
        }
    }
}
