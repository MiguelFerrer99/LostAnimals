//
//  SelectPhotoPopupRouter.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 6/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class SelectPhotoPopupRouter {
    // MARK: - Properties
    private weak var viewController: SelectPhotoPopupViewController?
    
    // MARK: - Init
    required init(viewController: SelectPhotoPopupViewController?) {
        self.viewController = viewController
    }
}

// MARK: - Functions
extension SelectPhotoPopupRouter {
    func dismissSelectPhotoPopup() {
        self.viewController?.dismissCurrentView(completion: nil)
    }
    
    func dismissSelectPhotoPopupAndRemovePhoto(comesFrom: SelectPhotoPopupComesFrom) {
        self.viewController?.dismissCurrentView(completion: {
            self.viewController?.delegate?.goTo(action: .removePhoto)
        })
    }
    
    func dismissSelectPhotoPopupAndChooseFromLibrary(comesFrom: SelectPhotoPopupComesFrom) {
        self.viewController?.dismissCurrentView(completion: {
            self.viewController?.delegate?.goTo(action: .choosePhoto)
        })
    }
    
    func dismissSelectPhotoPopupAndTakeAPhoto(comesFrom: SelectPhotoPopupComesFrom) {
        self.viewController?.dismissCurrentView(completion: {
            self.viewController?.delegate?.goTo(action: .takePhoto)
        })
    }
}
