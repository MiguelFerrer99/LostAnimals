//
//  PostScrollView.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 13/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

// MARK: - Functions
extension PostViewController {
    func configureScrollView(_ scrollView: UIScrollView) {
        scrollView.delegate = self
    }
}

// MARK: - UIScrollViewDelegate
extension PostViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.navigationController?.setNavigationBarHidden(shouldHideNavigationBar, animated: true)
    }
}
