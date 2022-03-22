//
//  ProfilePostsProtocols.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 3/2/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import Foundation

// MARK: - PostFiltersDelegate
extension ProfilePostsViewController: PostFiltersDelegate {
    func showPostFilters(filterType: FilterType, loadData: Bool) {
        viewModel.didPressPostsFilterPopup(filterType: filterType, loadData: loadData)
    }
}
