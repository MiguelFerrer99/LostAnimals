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
            self.viewController?.delegate?.goTo(action: .goToEditPost, postImageToShare: nil)
        })
    }
    
    func dismissPostOptionsPopupAndShowGuestPopup() {
        self.viewController?.dismissCurrentView(completion: {
            self.viewController?.delegate?.goTo(action: .showGuestPopup, postImageToShare: nil)
        })
    }
    
    func dismissPostOptionsPopupAndShowSuccessPopup() {
        self.viewController?.dismissCurrentView(completion: {
            self.viewController?.delegate?.goTo(action: .showSuccessPopup, postImageToShare: nil)
        })
    }
    
    func dismissPostOptionsPopupAndShowErrorPopup() {
        self.viewController?.dismissCurrentView(completion: {
            self.viewController?.delegate?.goTo(action: .showErrorPopup, postImageToShare: nil)
        })
    }
    
    func dismissPostOptionsAndShowActivityViewController(postImageToShare: UIImage) {
        self.viewController?.dismissCurrentView(completion: {
            self.viewController?.delegate?.goTo(action: .showActivityVC, postImageToShare: postImageToShare)
        })
    }
}
