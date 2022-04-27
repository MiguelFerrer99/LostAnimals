//
//  PostCollectionView.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 7/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

// MARK: - Functions
extension PostViewController {
    func configureCollectionView(_ collectionView: UICollectionView) {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PostImageCollectionViewCell.self)
        postImagesPageControl.numberOfPages = viewModel.postImages.count
    }
}

// MARK: - UICollectionViewDelegate
extension PostViewController: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let center = CGPoint(x: scrollView.contentOffset.x + (scrollView.frame.width / 2), y: (scrollView.frame.height / 2))
        if let ip = postImagesCollectionView.indexPathForItem(at: center) {
            postImagesPageControl.currentPage = ip.row
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didPressPostImage(indexPostImage: indexPath.row)
    }
}

// MARK: - UICollectionViewDataSource
extension PostViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.postImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let postImage = viewModel.postImages[indexPath.row]
        let summary = PostImageCollectionViewCellSummary(postImage: postImage, aspectImage: .scaleAspectFill)
        let cell = collectionView.dequeue(PostImageCollectionViewCell.self, for: indexPath)
        cell.display(summary: summary)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension PostViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}
