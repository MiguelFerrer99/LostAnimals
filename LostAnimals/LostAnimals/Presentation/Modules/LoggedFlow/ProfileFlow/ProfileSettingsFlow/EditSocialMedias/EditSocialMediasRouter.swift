//
//  EditSocialMediasRouter.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 6/2/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class EditSocialMediasRouter {
    // MARK: - Properties
    private weak var viewController: EditSocialMediasViewController?
    
    // MARK: - Init
    required init(viewController: EditSocialMediasViewController?) {
        self.viewController = viewController
    }
}

// MARK: - Functions
extension EditSocialMediasRouter {
    func goBack() {
        DispatchQueue.main.async {
            self.viewController?.pop()
        }
    }
    
    func goToWhereDoYouLiveCountries() {
        let viewController = Container.shared.whereDoYouLiveCountriesBuilder().build(comesFrom: .editSocialMediaDetails)
        viewController.delegate = self.viewController
        DispatchQueue.main.async {
            self.viewController?.push(viewController: viewController)
        }
    }
}
