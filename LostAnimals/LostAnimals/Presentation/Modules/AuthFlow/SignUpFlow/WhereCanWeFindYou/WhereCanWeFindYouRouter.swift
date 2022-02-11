//
//  WhereCanWeFindYouRouter.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 19/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit
import MapKit

final class WhereCanWeFindYouRouter {
    // MARK: - Properties
    private weak var viewController: WhereCanWeFindYouViewController?
    
    // MARK: - Init
    required init(viewController: WhereCanWeFindYouViewController?) {
        self.viewController = viewController
    }
    
    // MARK: - Functions
    func goBack(comesFrom: WhereCanWeFindYouComesFrom, searchResult: MKLocalSearchCompletion) {
        DispatchQueue.main.async {
            self.viewController?.delegate?.getWhereCanWeFindYou(whereCanWeFindYouSearchResult: searchResult)
            self.viewController?.pop()
        }
    }
}
