//
//  EditPersonalDetailsBuilder.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 5/2/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class EditPersonalDetailsBuilder {
    
    func build(me: User) -> EditPersonalDetailsViewController {
        let viewController = UIViewController.instantiate(viewController: EditPersonalDetailsViewController.self)
        
        let router = EditPersonalDetailsRouter(viewController: viewController)
        let viewModel = EditPersonalDetailsViewModel(router: router, me: me)
        
        viewController.viewModel = viewModel
        
        return viewController
    }
}
