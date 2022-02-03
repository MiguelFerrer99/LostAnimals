//
//  SocialMediaPostCollectionViewCell.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 31/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

class SocialMediaCollectionViewCell: UICollectionViewCell, Reusable {
    // MARK: - IBOutlets
    @IBOutlet weak var socialMediaIconImageView: UIImageView!
    @IBOutlet weak var socialMediaBackgroundImageView: CustomImageView!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailingConstraint: NSLayoutConstraint!
    
    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Functions
    func display(summary: SocialMediaCollectionViewCellSummary) {
        socialMediaIconImageView.image = summary.icon
        socialMediaBackgroundImageView.image = summary.backgroundImage
        
        leadingConstraint.constant = summary.leadingPadding
        trailingConstraint.constant = summary.trailingPadding
        self.layoutIfNeeded()
    }
}
