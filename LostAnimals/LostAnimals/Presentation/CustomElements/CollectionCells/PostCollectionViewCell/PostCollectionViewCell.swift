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
  @IBOutlet weak var postTypeImageView: UIImageView!
  @IBOutlet weak var postTypeWhiteImageView: UIImageView!
  @IBOutlet weak var animalTypeImageView: UIImageView!
  @IBOutlet weak var animalTypeWhiteImageView: UIImageView!
  @IBOutlet weak var animalNameLabel: UILabel!
  @IBOutlet weak var postImageView: UIImageView!
  
  // MARK: - Life cycle
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  // MARK: - Functions
  func display(summary: PostCollectionViewCellSummary) {
    postTypeImageView.image = UIImage(named: summary.postType.rawValue)
    postTypeWhiteImageView.image = UIImage(named: "\(summary.postType.rawValue)White")
    animalTypeImageView.image = UIImage(named: summary.animal.type.rawValue)
    animalTypeWhiteImageView.image = UIImage(named: "\(summary.animal.type.rawValue)White")
    animalNameLabel.text = summary.animal.name
    postImageView.image = summary.postImage
  }
}
