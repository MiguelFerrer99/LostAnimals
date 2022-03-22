//
//  OnboardingCollectionViewCell.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 28/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell, Reusable {
    // MARK: - IBOutlets
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

// MARK: - Functions
extension OnboardingCollectionViewCell {
    func display(summary: OnboardingCollectionViewCellSummary) {
        titleLabel.text = summary.title
        descriptionLabel.text = summary.description
    }
}
