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
  @IBOutlet weak var animalTypeImageView: UIImageView!
  @IBOutlet weak var animalNameLabel: UILabel!
  @IBOutlet weak var postImageView: UIImageView!
  
  // MARK: - Life cycle
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  // MARK: - Functions
  func display(summary: PostCollectionViewCellSummary) {
    switch summary.postType {
    case .lost:
      postTypeImageView.image = UIImage(named: "Lost")
    case .found:
      postTypeImageView.image = UIImage(named: "Found")
    case .adopt:
      postTypeImageView.image = UIImage(named: "Adopt")
    }
    switch summary.animal.type {
    case .dog:
      animalTypeImageView.image = UIImage(named: "Dog")
    case .bird:
      animalTypeImageView.image = UIImage(named: "Bird")
    case .cat:
      animalTypeImageView.image = UIImage(named: "Cat")
    case .turtle:
      animalTypeImageView.image = UIImage(named: "Turtle")
    case .snake:
      animalTypeImageView.image = UIImage(named: "Snake")
    case .rabbit:
      animalTypeImageView.image = UIImage(named: "Rabbit")
    case .other:
      animalTypeImageView.image = UIImage(systemName: "questionmark.circle.fill")
    }
    animalNameLabel.text = summary.animal.name
    postImageView.image = summary.postImage
  }
}
