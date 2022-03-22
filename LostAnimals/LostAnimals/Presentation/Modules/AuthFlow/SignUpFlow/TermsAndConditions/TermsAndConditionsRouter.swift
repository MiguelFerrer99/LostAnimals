//
//  TermsAndConditionsRouter.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 28/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

final class TermsAndConditionsRouter {
    // MARK: - Properties
    private weak var viewController: TermsAndConditionsViewController?
    
    // MARK: - Init
    required init(viewController: TermsAndConditionsViewController?) {
        self.viewController = viewController
    }
}
