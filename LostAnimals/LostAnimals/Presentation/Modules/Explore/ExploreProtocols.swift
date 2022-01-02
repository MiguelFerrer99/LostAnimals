//
//  ExploreProtocols.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 2/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import Foundation

extension ExploreViewController: PostFiltersDelegate {
  func showPostFiltersDelegate(filterType: ExploreFilterType) {
    viewModel.didPressPostsFilterPopup(filterType: filterType)
  }
}
