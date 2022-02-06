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
    private weak var viewController: ViewController?
    
    // MARK: - Init
    required init(viewController: ViewController?) {
        self.viewController = viewController
    }
    
    // MARK: - Functions
    func goToSignUp() {
        DispatchQueue.main.async {
            self.viewController?.pop()
        }
    }
    
    func goToEditSocialMedias() {
        DispatchQueue.main.async {
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
