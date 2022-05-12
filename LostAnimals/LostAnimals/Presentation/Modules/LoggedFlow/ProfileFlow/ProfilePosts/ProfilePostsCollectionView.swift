//
//  ProfilePostsCollectionView.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 3/2/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

// MARK: - Functions
extension ProfilePostsViewController {
    func configureCollectionView(_ collectionView: UICollectionView) {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(EmptyCollectionViewCell.self)
        collectionView.register(PostCollectionViewCell.self)
    }
}

// MARK: - UICollectionViewDelegate
extension ProfilePostsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // TODO: - Get post from viewModel
        /*let post = HardcodedData.savedPosts[indexPath.row]
        viewModel.didPressPost(post: post)*/
    }
}

// MARK: - UICollectionViewDataSource
extension ProfilePostsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        /*if HardcodedData.savedPosts.isEmpty { return 1 }
        else { return HardcodedData.savedPosts.count }*/
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        /*if HardcodedData.savedPosts.isEmpty {
            let summary = EmptyCollectionViewCellSummary(emptyTitle: "There are not available posts", emptyImage: UIImage(named: "NotAvailablePosts") ?? UIImage())
            let cell = collectionView.dequeue(EmptyCollectionViewCell.self, for: indexPath)
            cell.display(summary: summary)
            return cell
        } else {
            let post = HardcodedData.savedPosts[indexPath.row]
            let summary = PostCollectionViewCellSummary(postType: post.postType, animal: post.animal, postImage: post.animal.images.first ?? UIImage(named: "SelectPhotoPlaceholder"), leadingPadding: indexPath.row % 2 == 0 ? 20 : 10, trailingPadding: indexPath.row % 2 == 0 ? 10 : 20)
            let cell = collectionView.dequeue(PostCollectionViewCell.self, for: indexPath)
            cell.display(summary: summary)
            return cell
        }*/
        return UICollectionViewCell()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ProfilePostsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        /*let collectionViewRealHeight = collectionView.frame.height - statusBarHeight - navBarHeight - 50.0 - tabBarHeight
        if HardcodedData.savedPosts.isEmpty { return CGSize(width: collectionView.frame.width, height: collectionViewRealHeight) }
        else { return CGSize(width: collectionView.frame.width/2, height: collectionView.frame.height/3) }*/
        return CGSize(width: collectionView.frame.width/2, height: collectionView.frame.height/3)
    }
}
