//
//  SavedPostsProtocols.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 3/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import Foundation

extension SavedPostsViewController: PostFiltersDelegate {
  func showPostFiltersDelegate(filterType: FilterType) {
    viewModel.didPressPostsFilterPopup(filterType: filterType)
  }
}
