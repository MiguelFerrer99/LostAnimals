//
//  ProfileScrollView.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 26/3/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

// MARK: - Functions
extension ProfileViewController {
    func configureScrollView(_ scrollView: UIScrollView) {
        scrollView.delegate = self
    }
}

// MARK: - UIScrollViewDelegate
extension ProfileViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        DispatchQueue.main.async {
            self.navigationController?.setNavigationBarHidden(self.shouldHideNavigationBar, animated: true)
        }
    }
}
