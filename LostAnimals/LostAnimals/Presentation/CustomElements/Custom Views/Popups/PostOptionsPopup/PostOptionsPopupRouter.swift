//
//  PostOptionsPopupRouter.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 3/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class PostOptionsPopupRouter {
    // MARK: - Properties
    private weak var viewController: PostOptionsPopupViewController?
    
    // MARK: - Init
    required init(viewController: PostOptionsPopupViewController?) {
        self.viewController = viewController
    }
}

// MARK: - Functions
extension PostOptionsPopupRouter {
    func dismissPostOptionsPopup() {
        self.viewController?.dismissCurrentView(completion: nil)
    }
    
    func dismissPostOptionsPopupAndGoToEditPost() {
        self.viewController?.dismissCurrentView(completion: {
            self.viewController?.delegate?.goTo(action: .goToEditPost)
        })
    }
    
    func dismissPostOptionsPopupAndShowGuestPopup() {
        self.viewController?.dismissCurrentView(completion: {
            self.viewController?.delegate?.goTo(action: .showGuestPopup)
        })
    }
    
    func dismissPostOptionsPopupAndShowSuccessPopup() {
        self.viewController?.dismissCurrentView(completion: {
            self.viewController?.delegate?.goTo(action: .showSuccessPopup)
        })
    }
    
    func dismissPostOptionsPopupAndShowErrorPopup(error: String) {
        self.viewController?.dismissCurrentView(completion: {
            self.viewController?.delegate?.goTo(action: .showErrorPopup(error: error))
        })
    }
    
    func dismissPostOptionsAndShowActivityViewController(postImageToShare: UIImage) {
        self.viewController?.dismissCurrentView(completion: {
            self.viewController?.delegate?.goTo(action: .showActivityVC(imageToShare: postImageToShare))
        })
    }
}
