//
//  ExploreProtocols.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 2/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import Foundation

// MARK: - PostFiltersDelegate
extension ExploreViewController: PostFiltersDelegate {
    func showPostFilters(filterType: FilterType, loadData: Bool) {
        viewModel.didPressPostsFilterPopup(filterType: filterType, loadData: loadData)
    }
}
