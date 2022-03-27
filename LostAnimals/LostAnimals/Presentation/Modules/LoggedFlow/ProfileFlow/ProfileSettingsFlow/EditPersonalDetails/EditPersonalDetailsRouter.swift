//
//  EditPersonalDetailsRouter.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 5/2/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class EditPersonalDetailsRouter {
    // MARK: - Properties
    private weak var viewController: EditPersonalDetailsViewController?
    
    // MARK: - Init
    required init(viewController: EditPersonalDetailsViewController?) {
        self.viewController = viewController
    }
}

// MARK: - Functions
extension EditPersonalDetailsRouter {
    func goBack() {
        self.viewController?.pop()
    }
    
    func goToWhereDoYouLive() {
        DispatchQueue.main.async {
            let viewController = Container.shared.whereDoYouLiveCountriesBuilder().build(comesFrom: .editPersonalDetails)
            self.viewController?.push(viewController: viewController)
        }
    }
    
    func goToWhereCanWeFindYou() {
        DispatchQueue.main.async {
            let viewController = Container.shared.whereCanWeFindYou().build(comesFrom: .editPersonalDetails)
            viewController.delegate = self.viewController
            self.viewController?.push(viewController: viewController)
        }
    }
}
