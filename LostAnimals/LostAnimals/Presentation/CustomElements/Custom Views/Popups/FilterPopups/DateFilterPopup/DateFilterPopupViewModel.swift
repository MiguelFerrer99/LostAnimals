//
//  DateFilterPopupViewModel.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 3/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class DateFilterPopupViewModel {
    // MARK: - Properties
    private let router: DateFilterPopupRouter
    let loadData: Bool
    var postsPreviousToSelected = false
    var postsAfterSelected = false
    var postsPreviousToSelectedDate: Date? = nil
    var postsAfterSelectedDate: Date? = nil
    
    // MARK: - Init
    required init(router: DateFilterPopupRouter, loadData: Bool) {
        self.router = router
        self.loadData = loadData
    }
}

// MARK: - Life cycle
extension DateFilterPopupViewModel {
    func viewReady() {
        // Called when view is loaded and ready
    }
    
    func viewDidAppear() {
        // Called when view has appeared
    }
}

// MARK: - Functions
extension DateFilterPopupViewModel {
    func didPressApplyFilterButton() {
        Filters.setFilterValue(filterType: .all, enabled: false)
        Filters.setFilterValue(filterType: .date, enabled: true, dateFilterDatesBeforeOf: postsPreviousToSelectedDate, dateFilterDatesAfterOf: postsAfterSelectedDate)
        if postsPreviousToSelected && postsAfterSelected {
            Filters.setFilterTitle(type: .date, title: "Dates")
        } else if postsPreviousToSelected {
            Filters.setFilterTitle(type: .date, title: "Date")
        } else if postsAfterSelected {
            Filters.setFilterTitle(type: .date, title: "Date")
        }
        NotificationCenter.default.post(name: .UpdateFiltersUI, object: nil)
        self.router.dismissDateFilterPopup()
    }
    
    func didPressDismissButton() {
        self.router.dismissDateFilterPopup()
    }
}
