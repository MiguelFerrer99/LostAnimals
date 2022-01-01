//
//  OnboardingTableView.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 28/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func configureCollectionView(_ collectionView: UICollectionView) {
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.register(OnboardingCollectionViewCell.self)
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return onboardingStepsInfo.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let onboardingStepInfo = onboardingStepsInfo[indexPath.row]
    let summary = OnboardingCollectionViewCellSummary(title: onboardingStepInfo.title, description: onboardingStepInfo.description, image: onboardingStepInfo.image)
    let cell = collectionView.dequeue(OnboardingCollectionViewCell.self, for: indexPath)
    cell.display(summary: summary)
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
  }
}
