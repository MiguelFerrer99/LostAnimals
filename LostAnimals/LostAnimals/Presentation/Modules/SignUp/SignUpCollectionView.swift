//
//  SignUpCollectionView.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 7/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import Foundation
import UIKit

extension SignUpViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func configureCollectionView(_ collectionView: UICollectionView) {
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.register(PersonalDetailsCollectionViewCell.self)
    collectionView.register(AccountDetailsCollectionViewCell.self)
    collectionView.register(SocialMediaDetailsCollectionViewCell.self)
  }
  
  internal func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel.numberOfSteps
  }
  
  internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    switch indexPath.row {
    case 0:
      let personalDetailsCell = collectionView.dequeue(PersonalDetailsCollectionViewCell.self, for: indexPath)
      personalDetailsCell.signUpStepsDelegate = self
      personalDetailsCell.presenter = self
      return personalDetailsCell
    case 1:
      let accountDetails = collectionView.dequeue(AccountDetailsCollectionViewCell.self, for: indexPath)
      return accountDetails
    case 2:
      let socialMediaDetails = collectionView.dequeue(SocialMediaDetailsCollectionViewCell.self, for: indexPath)
      return socialMediaDetails
    default: return UICollectionViewCell()
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
  }
  
  internal func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    let center = CGPoint(x: scrollView.contentOffset.x + (scrollView.frame.width / 2), y: (scrollView.frame.height / 2))
    if let ip = stepsCollectionView.indexPathForItem(at: center) {
      switch ip.row {
      case 0:
        viewModel.currentStep = .personalDetails
      case 1:
        viewModel.currentStep = .accountDetails
      case 2:
        viewModel.currentStep = .socialMediaDetails
      default: return
      }
    }
  }
}
