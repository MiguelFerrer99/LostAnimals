//
//  ProfilePostsProtocols.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 3/2/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import Foundation

extension ProfilePostsViewController: PostFiltersDelegate {
    func showPostFilters(filterType: FilterType) {
        viewModel.didPressPostsFilterPopup(filterType: filterType)
    }
}
