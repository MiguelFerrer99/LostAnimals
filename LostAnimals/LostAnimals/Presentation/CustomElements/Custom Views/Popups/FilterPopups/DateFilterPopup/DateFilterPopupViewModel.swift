//
//  DateFilterPopupViewModel.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 3/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import Foundation
import UIKit

final class DateFilterPopupViewModel {
    
    // MARK: - Properties
    private let router: DateFilterPopupRouter
    var postsPreviousToSelected = false
    var postsAfterSelected = false
    var postsPreviousToSelectedDate = Date.today
    var postsAfterSelectedDate = Date.today
    
    // MARK: - Init
    required init(router: DateFilterPopupRouter) {
        self.router = router
    }
}

// MARK: - Life cycle
extension DateFilterPopupViewModel {
    func viewReady() {
        // Called when view is loaded and ready
    }
    
    func viewDidAppear() {
        
    }
}

// MARK: - Functions
extension DateFilterPopupViewModel {
    func didPressApplyFilterButton() {
        Filters.setFilterValue(filterType: .all, enabled: false)
        Filters.setFilterValue(filterType: .date, enabled: true, dateFilterDatesBeforeOf: postsPreviousToSelectedDate, dateFilterDatesAfterOf: postsAfterSelectedDate)
        NotificationCenter.default.post(name: .UpdateFiltersUI, object: nil)
        self.router.dismissDateFilterPopup()
    }
    
    func didPressDismissButton() {
        self.router.dismissDateFilterPopup()
    }
}
