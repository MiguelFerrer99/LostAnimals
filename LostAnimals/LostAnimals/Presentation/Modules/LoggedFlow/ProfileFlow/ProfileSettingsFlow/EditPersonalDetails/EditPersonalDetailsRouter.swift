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
    
    // MARK: - Functions
    func goBack() {
        DispatchQueue.main.async {
            self.viewController?.pop()
        }
    }
    
    func goToWhereDoYouLive() {
        let viewController = Container.shared.whereDoYouLiveCountriesBuilder().build(comesFrom: .editPersonalDetails)
        DispatchQueue.main.async {
            self.viewController?.push(viewController: viewController)
        }
    }
    
    func goToWhereCanWeFindYou() {
        let viewController = Container.shared.whereCanWeFindYou().build(comesFrom: .editPersonalDetails)
        DispatchQueue.main.async {
            self.viewController?.push(viewController: viewController)
        }
    }
}
