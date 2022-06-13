//
//  ExplorePostsFilterCollectionViewCell.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 11/6/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class ExplorePostsFilterCollectionViewCell: UICollectionViewCell, Reusable {
    // MARK: - IBOutlets
    @IBOutlet private weak var filterView: CustomView!
    @IBOutlet private weak var filterTitleLabel: UILabel!
    @IBOutlet private weak var leadingConstraint: NSLayoutConstraint!
    @IBOutlet private weak var trailingConstraint: NSLayoutConstraint!
    
    // MARK: - Life cycle
    override var isSelected: Bool {
        didSet {
            UIView.animate(withDuration: 0.2) {
                self.filterView.alpha = self.isSelected ? 1 : 0.5
            }
        }
    }
}

// MARK: - Functions
extension ExplorePostsFilterCollectionViewCell {
    func display(_ summary: ExplorePostsFilterCollectionViewCellSummary) {
        leadingConstraint.constant = summary.leadingPadding
        trailingConstraint.constant = summary.trailingPadding
        filterTitleLabel.text = summary.filter.filterTitle
    }
    
    func setFilterTitle(_ title: String) {
        filterTitleLabel.text = title
    }
}

// MARK: - Private functions
private extension ExplorePostsFilterCollectionViewCell {}
