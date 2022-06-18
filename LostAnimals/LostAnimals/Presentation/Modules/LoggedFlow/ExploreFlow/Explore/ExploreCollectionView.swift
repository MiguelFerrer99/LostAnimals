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
        if collectionView == filtersCollectionView {
            collectionView.allowsSelection = true
            collectionView.register(ExplorePostsFilterCollectionViewCell.self)
        } else {
            collectionView.register(LoadingCollectionViewCell.self)
            collectionView.register(EmptyCollectionViewCell.self)
            collectionView.register(PostCollectionViewCell.self)
        }
    }
}

// MARK: - UICollectionViewDelegate
extension ExploreViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if collectionView == filtersCollectionView {
            let filterType = FilterType(rawValue: indexPath.item) ?? .recent
            if viewModel.isLoading { return false }
            else if filterType == .animal {
                let loadData = collectionView.indexPathsForSelectedItems?.contains(indexPath) ?? false
                viewModel.didPressAnimalFilter(loadData: loadData)
                return false
            } else { return true }
        } else {
            return !(viewModel.isLoading || viewModel.posts.isEmpty)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == filtersCollectionView {
            setNewFilter(indexPath.item)
        } else {
            let post = viewModel.posts[indexPath.item]
            viewModel.didPressPost(post: post)
        }
    }
}

// MARK: - UICollectionViewDataSource
extension ExploreViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == filtersCollectionView {
            return Filters.currentFilters.count
        } else {
            if viewModel.isLoading || viewModel.posts.isEmpty { return 1 }
            else { return viewModel.posts.count }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == filtersCollectionView {
            var customIndexPathItem = indexPath.item
            if Filters.currentFilters.count == 5 && customIndexPathItem > 0 { customIndexPathItem += 1 }
            let filterType = FilterType(rawValue: customIndexPathItem) ?? .recent
            let postFilter = Filters.currentFilters[filterType] ?? PostsFilter(filterTitle: "Recent", filterType: .recent, enabled: true)
            let summary = ExplorePostsFilterCollectionViewCellSummary(filter: postFilter,
                                                                      leadingPadding: (indexPath.item == 0) ? 20 : 10,
                                                                      trailingPadding: (indexPath.item == Filters.currentFilters.count - 1) ? 20 : 10)
            let cell = collectionView.dequeue(ExplorePostsFilterCollectionViewCell.self, for: indexPath)
            cell.display(summary)
            return cell
        } else {
            if viewModel.isLoading {
                let summary = LoadingCollectionViewCellSummary(activityIndicatorStyle: .large)
                let cell = collectionView.dequeue(LoadingCollectionViewCell.self, for: indexPath)
                cell.display(summary)
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
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ExploreViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == filtersCollectionView {
            let isLast = indexPath.item == 0 || indexPath.item == Filters.currentFilters.count - 1
            return CGSize(width: isLast ? 120 : 110, height: collectionView.frame.height)
        } else {
            let collectionViewRealHeight = collectionView.frame.height - currentBarsHeight
            if viewModel.isLoading || viewModel.posts.isEmpty {
                return CGSize(width: collectionView.frame.width, height: collectionViewRealHeight)
            }
            else { return CGSize(width: collectionView.frame.width / 2, height: collectionView.frame.height / 1.8) }
        }
    }
}
