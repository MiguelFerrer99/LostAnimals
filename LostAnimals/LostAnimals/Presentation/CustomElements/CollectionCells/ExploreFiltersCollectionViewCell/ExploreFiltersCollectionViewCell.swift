//
//  ExploreFiltersCollectionViewCell.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 31/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

class ExploreFiltersCollectionViewCell: UICollectionViewCell, Reusable {
  
  // MARK: - IBOutlets
  @IBOutlet weak var filterView: CustomView!
  @IBOutlet weak var filterTitleLabel: UILabel!
  
  // MARK: - Life cycle
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override var isSelected: Bool {
    didSet {
      filterView.alpha = isSelected ? 1 : 0.5
    }
  }
  
  // MARK: - Functions
  func display(summary: ExploreFiltersCollectionViewCellSummary) {
    filterTitleLabel.text = summary.filterTitle
  }
}
