//
//  SelectPhotoPopupViewModel.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 6/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import Foundation

enum SelectPhotoPopupComesFrom: String {
    case editPost
    case newPost
    case profileSettings
}

final class SelectPhotoPopupViewModel {
    
    // MARK: - Properties
    private let router: SelectPhotoPopupRouter
    let showRemoveOption: Bool
    let comesFrom: SelectPhotoPopupComesFrom
    
    // MARK: - Init
    required init(router: SelectPhotoPopupRouter, showRemoveOption: Bool, comesFrom: SelectPhotoPopupComesFrom) {
        self.router = router
        self.showRemoveOption = showRemoveOption
        self.comesFrom = comesFrom
    }
}

// MARK: - Life cycle
extension SelectPhotoPopupViewModel {
    func viewReady() {
        // Called when view is loaded and ready
    }
    
    func viewDidAppear() {
        // Called when view has appeared
    }
}

// MARK: - Functions
extension SelectPhotoPopupViewModel {
    func didPressDismissButton() {
        self.router.dismissSelectPhotoPopup()
    }
    
    func didPressRemovePhotoButton() {
        self.router.dismissSelectPhotoPopupAndRemovePhoto(comesFrom: comesFrom)
    }
    
    func didPressChooseFromLibraryButton() {
        self.router.dismissSelectPhotoPopupAndChooseFromLibrary(comesFrom: comesFrom)
    }
    
    func didPressTakeAPhotoButton() {
        self.router.dismissSelectPhotoPopupAndTakeAPhoto(comesFrom: comesFrom)
    }
}
