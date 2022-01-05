//
//  AnimalTypeTableViewCell.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 5/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

class AnimalTypeTableViewCell: UITableViewCell, Reusable {
  // MARK: - IBOutlets
  @IBOutlet weak var animalTypeImageView: UIImageView!
  @IBOutlet weak var animalTypeLabel: UILabel!
  
  // MARK: - Life cycle
  override func awakeFromNib() {
    super.awakeFromNib()
    
    let bgView = UIView()
    bgView.backgroundColor = .customWhite.withAlphaComponent(0.3)
    self.selectedBackgroundView = bgView
  }
  
  // MARK: - Functions
  func display(summary: AnimalTypeTableViewCellSummary) {
    animalTypeImageView.image = summary.animalTypeImage
    animalTypeLabel.text = summary.animalTypeTitle
  }
}
