//
//  MyPetBuilder.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 3/7/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class MyPetBuilder {}

// MARK: - Functions
extension MyPetBuilder {
    func build(myPet: Pet?) -> MyPetViewController {
        let viewController = UIViewController.instantiate(viewController: MyPetViewController.self)
        let router = MyPetRouter(viewController: viewController)
        let viewModel = MyPetViewModel(router: router, myPet: myPet)
        viewController.viewModel = viewModel
        return viewController
    }
}
