//
//  EditSocialMediasBuilder.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 6/2/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class EditSocialMediasBuilder {
    
    func build(me: User) -> EditSocialMediasViewController {
        let viewController = UIViewController.instantiate(viewController: EditSocialMediasViewController.self)
        
        let router = EditSocialMediasRouter(viewController: viewController)
        let viewModel = EditSocialMediasViewModel(router: router, me: me)
        
        viewController.viewModel = viewModel
        
        return viewController
    }
}
