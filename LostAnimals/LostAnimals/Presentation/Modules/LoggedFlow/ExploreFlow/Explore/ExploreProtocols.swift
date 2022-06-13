//
//  ExploreProtocols.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 16/5/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

// MARK: - GoToMyProfileFromPostDelegate
extension ExploreViewController: GoToMyProfileFromPostDelegate {
    func goToMyProfile() {
        viewModel.goToMyProfile()
    }
}

// MARK: - AnimalFilterPopupDelegate
extension ExploreViewController: AnimalFilterPopupDelegate {
    func animalFilterApplied() {
        selectAnimalFilterCell()
    }
}
