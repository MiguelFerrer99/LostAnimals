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
        DispatchQueue.main.async {
            self.viewController?.dismissCurrentView(completion: nil)
        }
    }
    
    func dismissPostOptionsPopupAndGoToEditPost() {
        DispatchQueue.main.async {
            self.viewController?.dismissCurrentView(completion: {
                self.viewController?.delegate?.goTo(action: .goToEditPost, postImageToShare: nil)
            })
        }
    }
    
    func dismissPostOptionsPopupAndShowGuestPopup() {
        DispatchQueue.main.async {
            self.viewController?.dismissCurrentView(completion: {
                self.viewController?.delegate?.goTo(action: .showGuestPopup, postImageToShare: nil)
            })
        }
    }
    
    func dismissPostOptionsPopupAndShowSuccessPopup() {
        DispatchQueue.main.async {
            self.viewController?.dismissCurrentView(completion: {
                self.viewController?.delegate?.goTo(action: .showSuccessPopup, postImageToShare: nil)
            })
        }
    }
    
    func dismissPostOptionsPopupAndShowErrorPopup() {
        DispatchQueue.main.async {
            self.viewController?.dismissCurrentView(completion: {
                self.viewController?.delegate?.goTo(action: .showErrorPopup, postImageToShare: nil)
            })
        }
    }
    
    func dismissPostOptionsAndShowActivityViewController(postImageToShare: UIImage) {
        DispatchQueue.main.async {
            self.viewController?.dismissCurrentView(completion: {
                self.viewController?.delegate?.goTo(action: .showActivityVC, postImageToShare: postImageToShare)
            })
        }
    }
}
