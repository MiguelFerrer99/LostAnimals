//
//  PostProtocols.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 8/2/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import Foundation
import UIKit

extension PostViewController: ActionAfterPostOptionsDelegate {
    // MARK: - ActionAfterPostOptionsDelegate
    func goTo(action: ActionAfterPostOptions, postImageToShare: UIImage?) {
        switch action {
        case .goToEditPost:
            viewModel.didPressEditPostButton()
        case .showGuestPopup:
            viewModel.showGuestPopupFromPostOptionsPopup()
        case .showSuccessPopup:
            viewModel.showSuccessPopupFromPostOptionsPopup()
        case .showErrorPopup:
            viewModel.showErrorPopupFromPostOptionsPopup()
        case .showActivityVC:
            guard let postImageToShare = postImageToShare else { return }
            presentActivityVC(postImageToShare: postImageToShare)
        }
    }
}
