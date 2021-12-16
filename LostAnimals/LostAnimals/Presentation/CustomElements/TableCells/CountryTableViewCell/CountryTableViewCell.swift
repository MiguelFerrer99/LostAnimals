//
//  CountryTableViewCell.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 11/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

class CountryTableViewCell: UITableViewCell, Reusable {
  // MARK: - IBOutlets
  @IBOutlet weak var countryName: UILabel!
  
  // MARK: - Life cycle
  override func awakeFromNib() {
    super.awakeFromNib()
    
    let bgView = UIView()
    bgView.backgroundColor = .customWhite.withAlphaComponent(0.3)
    self.selectedBackgroundView = bgView
  }
  
  // MARK: - Functions
  func display(summary: CountryTableViewCellSummary) {
    countryName.text = summary.countryName
  }
}
