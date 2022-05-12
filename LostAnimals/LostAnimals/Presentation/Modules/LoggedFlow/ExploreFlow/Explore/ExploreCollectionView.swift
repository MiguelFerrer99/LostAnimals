//
//  ExploreCollectionView.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 31/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

// MARK: - Functions
extension ExploreViewController {
    func configureCollectionView(_ collectionView: UICollectionView) {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(LoadingCollectionViewCell.self)
        collectionView.register(EmptyCollectionViewCell.self)
        collectionView.register(PostCollectionViewCell.self)
    }
}

// MARK: - UICollectionViewDelegate
extension ExploreViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return !(viewModel.isLoading || viewModel.posts.isEmpty)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let post = viewModel.posts[indexPath.item]
        viewModel.didPressPost(post: post)
    }
}

// MARK: - UICollectionViewDataSource
extension ExploreViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if viewModel.isLoading || viewModel.posts.isEmpty { return 1 }
        else { return viewModel.posts.count }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if viewModel.isLoading {
            let cell = collectionView.dequeue(LoadingCollectionViewCell.self, for: indexPath)
            return cell
        } else if viewModel.posts.isEmpty {
            let summary = EmptyCollectionViewCellSummary(emptyTitle: "There are not available posts", emptyImage: UIImage(named: "Other") ?? UIImage())
            let cell = collectionView.dequeue(EmptyCollectionViewCell.self, for: indexPath)
            cell.display(summary: summary)
            return cell
        } else {
            let post = viewModel.posts[indexPath.item]
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
extension ExploreViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewRealHeight = collectionView.frame.height - currentBarsHeight
        if viewModel.isLoading || viewModel.posts.isEmpty {
            return CGSize(width: collectionView.frame.width, height: collectionViewRealHeight)
        }
        else { return CGSize(width: collectionView.frame.width/2, height: collectionView.frame.height/3) }
    }
}
