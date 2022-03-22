//
//  ContactWithPopupBuilder.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 7/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class ContactWithPopupBuilder {}

// MARK: - Functions
extension ContactWithPopupBuilder {
    func build(authorSocialMedias: [SocialMediaType: String]) -> ContactWithPopupViewController {
        let viewController = UIViewController.instantiate(viewController: ContactWithPopupViewController.self)
        let router = ContactWithPopupRouter(viewController: viewController)
        let viewModel = ContactWithPopupViewModel(router: router, authorSocialMedias: authorSocialMedias)
        viewController.viewModel = viewModel
        return viewController
    }
}
