//
//  EmptyCollectionViewCell.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 3/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class EmptyCollectionViewCell: UICollectionViewCell, Reusable {
    // MARK: - IBOutlets
    @IBOutlet private weak var emptyImageView: UIImageView!
    @IBOutlet private weak var emptyTitleLabel: UILabel!
    
    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

// MARK: - Functions
extension EmptyCollectionViewCell {
    func display(summary: EmptyCollectionViewCellSummary) {
        emptyImageView.image = summary.emptyImage
        emptyTitleLabel.text = summary.emptyTitle
    }
}
