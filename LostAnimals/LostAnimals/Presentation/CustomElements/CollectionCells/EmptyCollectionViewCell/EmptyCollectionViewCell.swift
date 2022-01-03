//
//  EmptyCollectionViewCell.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 3/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

class EmptyCollectionViewCell: UICollectionViewCell, Reusable {
  
  // MARK: - IBOutlets
  @IBOutlet weak var emptyImageView: UIImageView!
  @IBOutlet weak var emptyTitleLabel: UILabel!
  
  // MARK: - Life cycle
  override func awakeFromNib() {
    super.awakeFromNib()
  }
    
  // MARK: - Functions
  func display(summary: EmptyCollectionViewCellSummary) {
    emptyImageView.image = summary.emptyImage
    emptyTitleLabel.text = summary.emptyTitle
  }
}
