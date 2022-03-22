//
//  PostImagesCollectionView.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 7/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

// MARK: - Functions
extension PostImagesViewController {
    func configureCollectionView(_ collectionView: UICollectionView) {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PostImageCollectionViewCell.self)
    }
}

// MARK: - UICollectionViewDelegate
extension PostImagesViewController: UICollectionViewDelegate {}

// MARK: - UICollectionViewDataSource
extension PostImagesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.postImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let postImage = viewModel.postImages[indexPath.row]
        let summary = PostImageCollectionViewCellSummary(postImage: postImage ?? UIImage(), aspectImage: .scaleAspectFit)
        let cell = collectionView.dequeue(PostImageCollectionViewCell.self, for: indexPath)
        cell.display(summary: summary)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension PostImagesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}
