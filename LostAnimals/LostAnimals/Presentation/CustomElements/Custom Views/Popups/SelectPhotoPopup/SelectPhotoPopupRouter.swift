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
    private weak var viewController: ViewController?
    
    // MARK: - Init
    required init(viewController: ViewController?) {
        self.viewController = viewController
    }
    
    // MARK: - Functions
    func dismissSelectPhotoPopup() {
        DispatchQueue.main.async {
            self.viewController?.dismissCurrentView(completion: nil)
        }
    }
    
    func dismissSelectPhotoPopupAndRemovePhoto(comesFrom: SelectPhotoPopupComesFrom) {
        DispatchQueue.main.async {
            self.viewController?.dismissCurrentView(completion: {
                switch comesFrom {
                case .editPost:
                    NotificationCenter.default.post(name: .RemovePhotoFromSelectPhotoPopupFromEditPost, object: nil)
                case .newPost:
                    NotificationCenter.default.post(name: .RemovePhotoFromSelectPhotoPopupFromNewPost, object: nil)
                }
            })
        }
    }
    
    func dismissSelectPhotoPopupAndChooseFromLibrary(comesFrom: SelectPhotoPopupComesFrom) {
        DispatchQueue.main.async {
            self.viewController?.dismissCurrentView(completion: {
                switch comesFrom {
                case .editPost:
                    NotificationCenter.default.post(name: .ChooseFromLibraryFromSelectPhotoPopupFromEditPost, object: nil)
                case .newPost:
                    NotificationCenter.default.post(name: .ChooseFromLibraryFromSelectPhotoPopupFromNewPost, object: nil)
                }
            })
        }
    }
    
    func dismissSelectPhotoPopupAndTakeAPhoto(comesFrom: SelectPhotoPopupComesFrom) {
        DispatchQueue.main.async {
            self.viewController?.dismissCurrentView(completion: {
                switch comesFrom {
                case .editPost:
                    NotificationCenter.default.post(name: .TakeAPhotoFromSelectPhotoPopupFromEditPost, object: nil)
                case .newPost:
                    NotificationCenter.default.post(name: .TakeAPhotoFromSelectPhotoPopupFromNewPost, object: nil)
                }
            })
        }
    }
}
