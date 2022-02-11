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
    
    // MARK: - Functions
    func goToSignUp(dialCode: String) {
        DispatchQueue.main.async {
            self.viewController?.delegate?.getDialCode(dialCode: dialCode)
            self.viewController?.pop()
        }
    }
    
    func goToEditSocialMedias(dialCode: String) {
        DispatchQueue.main.async {
            self.viewController?.delegate?.getDialCode(dialCode: dialCode)
            self.viewController?.pop()
        }
    }
    
    func goToWhereDoYouLiveCities(comesFrom: WhereDoYouLiveComesFrom, country: Country, cities: [String]) {
        let viewController = Container.shared.whereDoYouLiveCitiesBuilder().build(comesFrom: comesFrom, country: country, cities: cities)
        DispatchQueue.main.async {
            self.viewController?.push(viewController: viewController)
        }
    }
}
