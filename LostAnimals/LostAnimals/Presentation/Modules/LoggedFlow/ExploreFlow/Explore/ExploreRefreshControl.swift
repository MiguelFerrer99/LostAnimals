//
//  ExploreRefreshControl.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 1/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

// MARK: - Functions
extension ExploreViewController {
    func configureRefreshControl(_ refreshControl: UIRefreshControl) {
        refreshControl.tintColor = .customBlack
        refreshControl.addTarget(self, action: #selector(refreshPosts), for: .valueChanged)
        postsCollectionView.refreshControl = refreshControl
    }
    
    @objc private func refreshPosts() {
        getPosts()
    }
}
