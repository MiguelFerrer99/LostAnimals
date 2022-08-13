//
//  PostCollectionViewCell.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 31/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

final class PostCollectionViewCell: UICollectionViewCell, Reusable {
    // MARK: - IBOutlets
    @IBOutlet private weak var postTypeLabel: UILabel!
    @IBOutlet private weak var animalTypeWhiteImageView: UIImageView!
    @IBOutlet private weak var animalNameLabel: UILabel!
    @IBOutlet private weak var postImageView: UIImageView!
    @IBOutlet private weak var leadingConstraint: NSLayoutConstraint!
    @IBOutlet private weak var trailingConstraint: NSLayoutConstraint!
    
    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        postTypeLabel.layer.masksToBounds = true
        postTypeLabel.layer.cornerRadius = postTypeLabel.frame.width / 2
    }
    
    override func prepareForReuse() {
        postImageView.image = UIImage(named: "DefaultHeaderImage")
    }
}

// MARK: - Functions
extension PostCollectionViewCell {
    func display(summary: PostCollectionViewCellSummary) {
        var postTypeLabelText = ""
        switch summary.postType {
        case .lost:  postTypeLabelText = .Post.PostTypeLost()
        case .found: postTypeLabelText = .Post.PostTypeFound()
        case .adopt: postTypeLabelText = .Post.PostTypeAdopt()
        }
        postTypeLabel.text = postTypeLabelText
        animalTypeWhiteImageView.image = UIImage(named: "\(summary.animalType.rawValue)White")
        animalNameLabel.isHidden = summary.postType == .found
        animalNameLabel.text = summary.animalName ?? .Commons.NotSpecifiedMale()
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
