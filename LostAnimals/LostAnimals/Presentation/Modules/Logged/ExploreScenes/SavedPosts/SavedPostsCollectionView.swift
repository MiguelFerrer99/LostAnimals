//
//  SavedPostsCollectionView.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 3/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

// MARK: - Functions
extension SavedPostsViewController {
    func configureCollectionView(_ collectionView: UICollectionView) {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(LoadingCollectionViewCell.self)
        collectionView.register(EmptyCollectionViewCell.self)
        collectionView.register(PostCollectionViewCell.self)
    }
}

// MARK: - UICollectionViewDelegate
extension SavedPostsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return !(viewModel.isLoading || viewModel.savedPosts.isEmpty)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let post = viewModel.savedPosts[indexPath.item]
        viewModel.didPressPost(post: post)
    }
}

// MARK: - UICollectionViewDataSource
extension SavedPostsViewController: UICollectionViewDataSource {    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if viewModel.isLoading || viewModel.savedPosts.isEmpty { return 1 }
        else { return viewModel.savedPosts.count }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if viewModel.isLoading {
            let summary = LoadingCollectionViewCellSummary(activityIndicatorStyle: .large)
            let cell = collectionView.dequeue(LoadingCollectionViewCell.self, for: indexPath)
            cell.display(summary)
            return cell
        } else if viewModel.savedPosts.isEmpty {
            let summary = EmptyCollectionViewCellSummary(emptyTitle: .Commons.NoPostsAvailable(), emptyImage: UIImage(named: "Other") ?? UIImage())
            let cell = collectionView.dequeue(EmptyCollectionViewCell.self, for: indexPath)
            cell.display(summary: summary)
            return cell
        } else {
            let post = viewModel.savedPosts[indexPath.item]
            let summary = PostCollectionViewCellSummary(postType: post.postType,
                                                        animalName: post.animalName,
                                                        animalType: post.animalType,
                                                        postURLImage: post.urlImage1 ?? "",
                                                        leadingPadding: indexPath.item % 2 == 0 ? 20 : 10,
                                                        trailingPadding: indexPath.item % 2 == 0 ? 10 : 20)
            let cell = collectionView.dequeue(PostCollectionViewCell.self, for: indexPath)
            cell.display(summary: summary)
            return cell
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension SavedPostsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewRealHeight = collectionView.frame.height - self.barHeights
        if viewModel.isLoading || viewModel.savedPosts.isEmpty {
            return CGSize(width: collectionView.frame.width, height: collectionViewRealHeight)
        }
        else { return CGSize(width: collectionView.frame.width / 2, height: collectionView.frame.height / 2.7) }
    }
}
