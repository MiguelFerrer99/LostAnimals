//
//  PostProtocols.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 8/2/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ActionAfterPostOptionsDelegate
extension PostViewController: ActionAfterPostOptionsDelegate {
    func goTo(action: ActionAfterPostOptions) {
        switch action {
        case .goToEditPost:
            viewModel.didPressEditPostButton()
        case .showGuestPopup:
            viewModel.showGuestPopupFromPostOptionsPopup()
        case .showSuccessPopup:
            viewModel.showSuccessPopupFromPostOptionsPopup {
                self.pop()
            }
        case .showErrorPopup(let error):
            viewModel.showErrorPopupFromPostOptionsPopup(error: error)
        case .showActivityVC(let image):
            guard let postImageToShare = image else { return }
            presentActivityVC(postImageToShare: postImageToShare)
        }
    }
}
