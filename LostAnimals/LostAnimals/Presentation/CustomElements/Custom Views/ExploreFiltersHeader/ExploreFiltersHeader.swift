//
//  ExploreFiltersHeader.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 31/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

class ExploreFiltersHeader: UICollectionReusableView, Reusable {
  
  // MARK: - IBOutlets
  @IBOutlet weak var filtersCollectionView: UICollectionView!
  
  // MARK: - Life cycle
  override func awakeFromNib() {
    super.awakeFromNib()
    
    setupUI()
  }
  
  // MARK: - Functions
  private func setupUI() {
    preselectAllFilter()
    configureCollectionView(filtersCollectionView)
  }
  
  private func preselectAllFilter() {
    filtersCollectionView.performBatchUpdates(nil) { result in
      if result { self.filtersCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .left) }
    }
  }
}
