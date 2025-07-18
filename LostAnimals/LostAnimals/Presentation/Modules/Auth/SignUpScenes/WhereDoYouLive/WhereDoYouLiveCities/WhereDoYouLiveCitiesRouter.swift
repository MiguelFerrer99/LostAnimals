//
//  WhereDoYouLiveCitiesRouter.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 11/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

final class WhereDoYouLiveCitiesRouter {
    // MARK: - Properties
    private weak var viewController: WhereDoYouLiveCitiesViewController?
    
    // MARK: - Init
    required init(viewController: WhereDoYouLiveCitiesViewController?) {
        self.viewController = viewController
    }
}

// MARK: - Functions
extension WhereDoYouLiveCitiesRouter {
    func goToSignUp(whereDoYouLive: String) {
        DispatchQueue.main.async {
            guard let viewController = self.viewController?.navigationController?.viewControllers[1] as? SignUpViewController else { return }
            NotificationCenter.default.post(name: .SendWhereDoYouLiveToSignUp, object: nil, userInfo: ["whereDoYouLive": whereDoYouLive])
            self.viewController?.navigationController?.popToViewController(viewController, animated: true)
        }
    }
    
    func goToEditPersonalDetails(whereDoYouLive: String) {
        DispatchQueue.main.async {
            guard let viewController = self.viewController?.navigationController?.viewControllers[2] as? EditPersonalDetailsViewController else { return }
            NotificationCenter.default.post(name: .SendWhereDoYouLiveToEditPersonalDetails, object: nil, userInfo: ["whereDoYouLive": whereDoYouLive])
            self.viewController?.navigationController?.popToViewController(viewController, animated: true)
        }
    }
}
