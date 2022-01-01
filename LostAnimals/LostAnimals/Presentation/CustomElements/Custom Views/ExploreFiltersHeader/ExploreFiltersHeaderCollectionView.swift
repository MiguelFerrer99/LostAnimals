//
//  ExploreFiltersHeaderCollectionView.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 31/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

extension ExploreFiltersHeader: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func configureCollectionView(_ collectionView: UICollectionView) {
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.allowsMultipleSelection = true
    collectionView.register(ExploreFiltersCollectionViewCell.self)
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel.filters.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeue(ExploreFiltersCollectionViewCell.self, for: indexPath)
    cell.display(summary: viewModel.filters[indexPath.row])
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 90, height: collectionView.frame.height)
  }
  
  func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
    return true
  }
}
