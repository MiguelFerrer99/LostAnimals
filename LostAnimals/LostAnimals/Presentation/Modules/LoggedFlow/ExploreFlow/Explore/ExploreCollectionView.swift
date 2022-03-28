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
        collectionView.register(supplementaryView: ExploreFiltersHeader.self)
        collectionView.register(EmptyCollectionViewCell.self)
        collectionView.register(PostCollectionViewCell.self)
    }
}

// MARK: - UICollectionViewDelegate
extension ExploreViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (collectionView.cellForItem(at: indexPath) as? PostCollectionViewCell) != nil {
            let post = HardcodedData.explorePosts[indexPath.row]
            viewModel.didPressPost(post: post)
        }
    }
}

// MARK: - UICollectionViewDelegate & UICollectionViewDataSource
extension ExploreViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let exploreFiltersHeader = collectionView.dequeue(supplementaryView: ExploreFiltersHeader.self, for: indexPath)
            exploreFiltersHeader.postFiltersDelegate = self
            return exploreFiltersHeader
        default: return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if HardcodedData.explorePosts.isEmpty { return 1 }
        else { return HardcodedData.explorePosts.count }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if HardcodedData.explorePosts.isEmpty {
            let summary = EmptyCollectionViewCellSummary(emptyTitle: "There are not available posts", emptyImage: UIImage(named: "Other") ?? UIImage())
            let cell = collectionView.dequeue(EmptyCollectionViewCell.self, for: indexPath)
            cell.display(summary: summary)
            return cell
        } else {
            let post = HardcodedData.explorePosts[indexPath.row]
            let summary = PostCollectionViewCellSummary(postType: post.postType, animal: post.animal, postImage: post.animal.images.first ?? UIImage(named: "SelectPhotoPlaceholder"), leadingPadding: indexPath.row % 2 == 0 ? 20 : 10, trailingPadding: indexPath.row % 2 == 0 ? 10 : 20)
            let cell = collectionView.dequeue(PostCollectionViewCell.self, for: indexPath)
            cell.display(summary: summary)
            return cell
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ExploreViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewRealHeight = collectionView.frame.height - statusBarHeight - navBarHeight - 50.0 - tabBarHeight
        if HardcodedData.explorePosts.isEmpty { return CGSize(width: collectionView.frame.width, height: collectionViewRealHeight) }
        else { return CGSize(width: collectionView.frame.width/2, height: collectionView.frame.height/3) }
    }
}
