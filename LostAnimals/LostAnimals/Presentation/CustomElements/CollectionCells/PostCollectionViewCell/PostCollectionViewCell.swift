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
    @IBOutlet private weak var animalTypeWhiteImageView: UIImageView!
    @IBOutlet private weak var animalNameLabel: UILabel!
    @IBOutlet private weak var postImageView: UIImageView!
    @IBOutlet private weak var leadingConstraint: NSLayoutConstraint!
    @IBOutlet private weak var trailingConstraint: NSLayoutConstraint!
    
    // MARK: - Life cycle
    override func prepareForReuse() {
        animalNameLabel.text = nil
    }
}

// MARK: - Functions
extension PostCollectionViewCell {
    func display(summary: PostCollectionViewCellSummary) {
        postTypeImageView.image = UIImage(named: summary.postType.rawValue)
        postTypeWhiteImageView.image = UIImage(named: "\(summary.postType.rawValue)White")
        animalTypeWhiteImageView.image = UIImage(named: "\(summary.animalType.rawValue)White")
        animalNameLabel.text = summary.animalName
        getPostImage(from: summary.postURLImage)
        
        leadingConstraint.constant = summary.leadingPadding
        trailingConstraint.constant = summary.trailingPadding
        self.layoutIfNeeded()
    }
    
    func getPostImage(from url: String) {
        url.getURLImage { image in
            if let image = image {
                UIView.transition(with: self.postImageView, duration: 0.3, options: .transitionCrossDissolve, animations: {
                    DispatchQueue.main.async { self.postImageView.image = image }
                }, completion: nil)
            }
        }
    }
}
