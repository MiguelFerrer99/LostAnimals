//
//  ExploreFiltersHeader.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 31/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

class ExploreFiltersHeader: UICollectionReusableView, ViewModelCell {
  typealias T = ExploreFiltersHeaderViewModel
  
  // MARK: - IBOutlets
  @IBOutlet weak var filtersCollectionView: UICollectionView!
  
  // MARK: - Properties
  var viewModel: ExploreFiltersHeaderViewModel! {
    didSet { fillUI() }
  }
  
  // MARK: - Life cycle
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  // MARK: - Functions
  private func fillUI() {
    configureCollectionView(filtersCollectionView)
    preselectAllFilter()
  }
  
  private func preselectAllFilter() {
    filtersCollectionView.performBatchUpdates(nil) { result in
      if result { self.filtersCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .left) }
    }
  }
}
