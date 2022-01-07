//
//  PostImageCollectionViewCell.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 7/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

class PostImageCollectionViewCell: UICollectionViewCell, Reusable {
  // MARK: - IBOutlets
  @IBOutlet weak var postImageView: UIImageView!
  
  // MARK: - Life cycle
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  // MARK: - Functions
  func display(summary: PostImageCollectionViewCellSummary) {
    postImageView.image = summary.postImage
  }
}
