//
//  ExploreFiltersCollectionViewCell.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 31/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

class ExploreFiltersCollectionViewCell: UICollectionViewCell, Reusable {
    
    // MARK: - IBOutlets
    @IBOutlet weak var filterView: CustomView!
    @IBOutlet weak var filterTitleLabel: UILabel!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailingConstraint: NSLayoutConstraint!
    
    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override var isSelected: Bool {
        didSet {
            filterView.alpha = isSelected ? 1 : 0.5
        }
    }
    
    // MARK: - Functions
    func display(summary: ExploreFiltersCollectionViewCellSummary) {
        filterTitleLabel.text = summary.filterTitle
        leadingConstraint.constant = summary.index == 0 ? 20 : 5
        trailingConstraint.constant = summary.index == Filters.currentFilters.count - 1 ? 20 : 5
        self.layoutIfNeeded()
    }
}
