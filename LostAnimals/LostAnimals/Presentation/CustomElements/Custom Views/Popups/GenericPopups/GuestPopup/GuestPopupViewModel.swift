//
//  GuestPopupViewModel.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 6/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import Foundation

final class GuestPopupViewModel {
    // MARK: - Properties
    private let router: GuestPopupRouter
    
    // MARK: - Init
    required init(router: GuestPopupRouter) {
        self.router = router
    }
}

// MARK: - Life cycle
extension GuestPopupViewModel {
    func viewReady() {
        // Called when view is loaded and ready
    }
    
    func viewDidAppear() {
        // Called when view has appeared
    }
}

// MARK: - Functions
extension GuestPopupViewModel {
    func didPressDismissButton() {
        self.router.dismissGuestPopup()
    }
    
    func didPressGoToStartupButton() {
        self.router.changeRootToStartup()
    }
}
