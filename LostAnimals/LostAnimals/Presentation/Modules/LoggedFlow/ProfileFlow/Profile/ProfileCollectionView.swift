//
//  ProfileCollectionView.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 20/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import Foundation
import UIKit

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  func configureCollectionView(_ collectionView: UICollectionView) {
    collectionView.delegate = self
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    return UICollectionViewCell()
  }
}
