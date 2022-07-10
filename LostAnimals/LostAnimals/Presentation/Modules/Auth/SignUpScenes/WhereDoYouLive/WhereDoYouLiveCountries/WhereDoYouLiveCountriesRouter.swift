//
//  WhereDoYouLiveCountriesRouter.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 10/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

final class WhereDoYouLiveCountriesRouter {
    // MARK: - Properties
    private weak var viewController: WhereDoYouLiveCountriesViewController?
    
    // MARK: - Init
    required init(viewController: WhereDoYouLiveCountriesViewController?) {
        self.viewController = viewController
    }
}

// MARK: - Functions
extension WhereDoYouLiveCountriesRouter {
    func goToSignUp(dialCode: String) {
        self.viewController?.delegate?.getDialCode(dialCode: dialCode)
        self.viewController?.pop()
    }
    
    func goToEditSocialMedias(dialCode: String) {
        self.viewController?.delegate?.getDialCode(dialCode: dialCode)
        self.viewController?.pop()
    }
    
    func goToWhereDoYouLiveCities(comesFrom: WhereDoYouLiveComesFrom, country: Country, cities: [String]) {
        DispatchQueue.main.async {
            let viewController = Container.shared.whereDoYouLiveCitiesBuilder().build(comesFrom: comesFrom, country: country, cities: cities)
            self.viewController?.push(viewController: viewController)
        }
    }
}
