//
//  PostCollectionViewCell.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 31/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

class PostCollectionViewCell: UICollectionViewCell, Reusable {
    // MARK: - IBOutlets
    @IBOutlet private weak var postTypeImageView: UIImageView!
    @IBOutlet private weak var postTypeWhiteImageView: UIImageView!
    @IBOutlet private weak var animalTypeImageView: UIImageView!
    @IBOutlet private weak var animalTypeWhiteImageView: UIImageView!
    @IBOutlet private weak var animalNameLabel: UILabel!
    @IBOutlet private weak var postImageView: UIImageView!
    @IBOutlet private weak var leadingConstraint: NSLayoutConstraint!
    @IBOutlet private weak var trailingConstraint: NSLayoutConstraint!
    
    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

// MARK: - Functions
extension PostCollectionViewCell {
    func display(summary: PostCollectionViewCellSummary) {
        postTypeImageView.image = UIImage(named: summary.postType.rawValue)
        postTypeWhiteImageView.image = UIImage(named: "\(summary.postType.rawValue)White")
        animalTypeImageView.image = UIImage(named: summary.animalType.rawValue)
        animalTypeWhiteImageView.image = UIImage(named: "\(summary.animalType.rawValue)White")
        animalNameLabel.text = summary.animalName
        postImageView.image = summary.postImage
        
        leadingConstraint.constant = summary.leadingPadding
        trailingConstraint.constant = summary.trailingPadding
        self.layoutIfNeeded()
    }
}
