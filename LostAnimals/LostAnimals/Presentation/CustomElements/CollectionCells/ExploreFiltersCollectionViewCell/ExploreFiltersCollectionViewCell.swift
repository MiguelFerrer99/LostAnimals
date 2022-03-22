//
//  ExploreFiltersCollectionViewCell.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 31/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

// MARK: - Protocols
protocol ExploreFilterDelegate: AnyObject {
    func disableFilter(filterType: FilterType)
}

class ExploreFiltersCollectionViewCell: UICollectionViewCell, Reusable {
    // MARK: - IBOutlets
    @IBOutlet private weak var filterView: CustomView!
    @IBOutlet private weak var disableFilterButton: UIButton!
    @IBOutlet private weak var leadingConstraint: NSLayoutConstraint!
    @IBOutlet private weak var trailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var filterTitleLabel: UILabel!
    
    // MARK: - Properties
    weak var delegate: ExploreFilterDelegate?
    private var filterType: FilterType?
    
    // MARK: - Life cycle
    override func prepareForReuse() {
        disableFilterButton.isHidden = (!(Filters.currentFilters[filterType ?? .all]?.enabled ?? false) && filterType != .all) || (filterType == .all)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override var isSelected: Bool {
        didSet {
            filterView.alpha = isSelected ? 1 : 0.5
        }
    }
}

// MARK: - Functions
extension ExploreFiltersCollectionViewCell {
    func showDisableFilterButton() {
        self.disableFilterButton.isHidden = false
    }
    
    func hideDisableFilterButton() {
        self.disableFilterButton.isHidden = true
    }
    
    func display(summary: ExploreFiltersCollectionViewCellSummary) {
        filterType = summary.filterType
        filterTitleLabel.text = summary.filterTitle
        leadingConstraint.constant = summary.index == 0 ? 20 : 5
        trailingConstraint.constant = summary.index == Filters.currentFilters.count - 1 ? 20 : 5
        self.layoutIfNeeded()
    }
}

// MARK: - IBActions
private extension ExploreFiltersCollectionViewCell {
    @IBAction func disableFilterButtonPressed(_ sender: UIButton) {
        guard let filterType = filterType else { return }
        hideDisableFilterButton()
        delegate?.disableFilter(filterType: filterType)
    }
}
