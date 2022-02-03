//
//  SuccessPopupViewModel.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 6/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import Foundation

final class SuccessPopupViewModel {
    
    // MARK: - Properties
    private let router: SuccessPopupRouter
    let successTitle: String
    let action: ()?
    
    // MARK: - Init
    required init(router: SuccessPopupRouter, successTitle: String, action: ()? = nil) {
        self.router = router
        self.successTitle = successTitle
        self.action = action
    }
}

// MARK: - Life cycle
extension SuccessPopupViewModel {
    func viewReady() {
        // Called when view is loaded and ready
    }
    
    func viewDidAppear() {
        // Called when view has appeared
    }
}

// MARK: - Functions
extension SuccessPopupViewModel {  
    func didPressOkButton() {
        self.router.dismissSuccessPopup(action: action)
    }
}
