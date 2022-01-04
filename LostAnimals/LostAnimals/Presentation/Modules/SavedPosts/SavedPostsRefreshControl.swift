//
//  SavedPostsRefreshControl.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 3/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

extension SavedPostsViewController {
  func configureRefreshControl(_ refreshControl: UIRefreshControl) {
    refreshControl.tintColor = .customBlack
    refreshControl.addTarget(self, action: #selector(refreshPosts), for: .valueChanged)
    savedPostsCollectionView.addSubview(refreshControl)
  }
  
  @objc private func refreshPosts() {
    refreshControl.beginRefreshing()
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
      self.refreshControl.endRefreshing()
    }
  }
}
