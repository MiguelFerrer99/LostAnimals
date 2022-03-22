//
//  ErrorPopupViewModel.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 6/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

final class ErrorPopupViewModel {
    // MARK: - Properties
    private let router: ErrorPopupRouter
    let errorTitle: String
    let action: ()?
    
    // MARK: - Init
    required init(router: ErrorPopupRouter, errorTitle: String, action: ()? = nil) {
        self.router = router
        self.errorTitle = errorTitle
        self.action = action
    }
}

// MARK: - Life cycle
extension ErrorPopupViewModel {
    func viewReady() {
        // Called when view is loaded and ready
    }
    
    func viewDidAppear() {
        // Called when view has appeared
    }
}

// MARK: - Functions
extension ErrorPopupViewModel {  
    func didPressOkButton() {
        self.router.dismissErrorPopup(action: action)
    }
}
