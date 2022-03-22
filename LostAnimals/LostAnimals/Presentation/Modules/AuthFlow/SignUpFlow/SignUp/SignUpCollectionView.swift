//
//  SignUpCollectionView.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 7/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

// MARK: - Functions
extension SignUpViewController {
    func configureCollectionView(_ collectionView: UICollectionView) {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PersonalDetailsCollectionViewCell.self)
        collectionView.register(AccountDetailsCollectionViewCell.self)
        collectionView.register(SocialMediaDetailsCollectionViewCell.self)
    }
}

// MARK: - UICollectionViewDelegate & UICollectionViewDataSource
extension SignUpViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfSteps
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case 0:
            let personalDetailsCellVM = PersonalDetailsCollectionViewCellViewModel()
            let personalDetailsCell = collectionView.dequeue(PersonalDetailsCollectionViewCell.self, for: indexPath, viewModel: personalDetailsCellVM)
            personalDetailsCell.signUpStepsDelegate = self
            return personalDetailsCell
        case 1:
            let accountDetailsCellVM = AccountDetailsCollectionViewCellViewModel()
            let accountDetailsCell = collectionView.dequeue(AccountDetailsCollectionViewCell.self, for: indexPath, viewModel: accountDetailsCellVM)
            accountDetailsCell.signUpStepsDelegate = self
            return accountDetailsCell
        case 2:
            let socialMediaDetailsCellVM = SocialMediaDetailsCollectionViewCellViewModel()
            let socialMediaDetailsCell = collectionView.dequeue(SocialMediaDetailsCollectionViewCell.self, for: indexPath, viewModel: socialMediaDetailsCellVM)
            socialMediaDetailsCell.signUpStepsDelegate = self
            return socialMediaDetailsCell
        default: return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension SignUpViewController: UICollectionViewDelegateFlowLayout {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
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
