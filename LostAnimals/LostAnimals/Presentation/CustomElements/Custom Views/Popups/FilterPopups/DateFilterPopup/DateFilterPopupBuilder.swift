//
//  DateFilterPopupBuilder.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 3/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class DateFilterPopupBuilder {
    
    func build(loadData: Bool) -> DateFilterPopupViewController {
        
        let viewController = UIViewController.instantiate(viewController: DateFilterPopupViewController.self)
        
        let router = DateFilterPopupRouter(viewController: viewController)
        let viewModel = DateFilterPopupViewModel(router: router, loadData: loadData)
        
        viewController.viewModel = viewModel
        
        return viewController
    }
}
