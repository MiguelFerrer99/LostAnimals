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
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  
  // MARK: - Life cycle
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  // MARK: - Functions  
  func display(summary: OnboardingCollectionViewCellSummary) {
    titleLabel.text = summary.title
    descriptionLabel.text = summary.description
  }
}
