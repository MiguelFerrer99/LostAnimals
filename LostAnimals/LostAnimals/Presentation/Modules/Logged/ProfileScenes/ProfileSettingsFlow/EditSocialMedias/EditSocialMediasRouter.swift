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
        self.viewController?.pop()
    }
    
    func goToWhereDoYouLiveCountries() {
        DispatchQueue.main.async {
            let viewController = Container.shared.whereDoYouLiveCountriesBuilder().build(comesFrom: .editSocialMediaDetails)
            viewController.delegate = self.viewController
            self.viewController?.push(viewController: viewController)
        }
    }
}
