//
//  ExploreFiltersHeaderProtocols.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 12/2/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import Foundation

extension ExploreFiltersHeader: ExploreFilterDelegate {
    // MARK: - ExploreFilterDelegate
    func disableFilter(filterType: FilterType) {
        Filters.setFilterValue(filterType: filterType, enabled: false)
        if Filters.currentFilters.allSatisfy({ $0.value.enabled == false }) {
            Filters.setFilterValue(filterType: .all, enabled: true)
        }
        NotificationCenter.default.post(name: .UpdateFiltersUI, object: nil)
    }
}
