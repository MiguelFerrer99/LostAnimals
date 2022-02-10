//
//  DateFilterPopupRouter.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 3/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class DateFilterPopupRouter {
    // MARK: - Properties
    private weak var viewController: DateFilterPopupViewController?
    
    // MARK: - Init
    required init(viewController: DateFilterPopupViewController?) {
        self.viewController = viewController
    }
    
    // MARK: - Functions
    func dismissDateFilterPopup() {
        DispatchQueue.main.async {
            self.viewController?.dismissCurrentView(completion: nil)
        }
    }
}
