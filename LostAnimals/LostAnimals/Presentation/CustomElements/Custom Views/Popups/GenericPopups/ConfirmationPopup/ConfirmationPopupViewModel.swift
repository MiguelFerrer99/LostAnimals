//
//  ConfirmationPopupViewModel.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 22/3/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

final class ConfirmationPopupViewModel {
    // MARK: - Properties
    private let router: ConfirmationPopupRouter
    let titleText: String
    let yesAction: (() -> Void)?
    
    // MARK: - Init
    required init(router: ConfirmationPopupRouter, titleText: String, yesAction: (() -> Void)? = nil) {
        self.router = router
        self.titleText = titleText
        self.yesAction = yesAction
    }
}

// MARK: - Life cycle
extension ConfirmationPopupViewModel {
    func viewReady() {
        // Called when view is loaded and ready
    }
    
    func viewDidAppear() {
        // Called when view has appeared
    }
}

// MARK: - Functions
extension ConfirmationPopupViewModel {
    func didPressDismissButton() {
        self.router.dismissConfirmationPopup()
    }
    
    func didPressYesButton() {
        self.router.dismissConfirmationPopup(yesAction: yesAction)
    }
}
