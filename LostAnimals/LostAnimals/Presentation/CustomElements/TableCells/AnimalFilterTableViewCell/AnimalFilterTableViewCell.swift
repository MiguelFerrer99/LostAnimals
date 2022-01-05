//
//  AnimalFilterTableViewCell.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 2/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

class AnimalFilterTableViewCell: UITableViewCell, Reusable {
  
  // MARK: - IBOutlets
  @IBOutlet weak var animalTypeImageView: UIImageView!
  @IBOutlet weak var animalTypeTitleLabel: UILabel!
  @IBOutlet weak var checkmarkView: UIView!
  
  // MARK: - Life cycle
  override func awakeFromNib() {
    super.awakeFromNib()
    
    let bgView = UIView()
    bgView.backgroundColor = .clear
    self.selectedBackgroundView = bgView
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    checkmarkView.isHidden = !selected
  }
  
  // MARK: - Functions
  func display(summary: AnimalFilterTableViewCellSummary) {
    animalTypeImageView.image = summary.animalTypeImage
    animalTypeTitleLabel.text = summary.animalTypeTitle
  }
}
