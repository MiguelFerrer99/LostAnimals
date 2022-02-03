//
//  PostScrollView.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 13/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import Foundation
import UIKit

extension PostViewController: UIScrollViewDelegate {
    // MARK: - Functions
    func configureScrollView(_ scrollView: UIScrollView) {
        scrollView.delegate = self
    }
    
    // MARK: - UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.navigationController?.setNavigationBarHidden(shouldHideNavigationBar, animated: true)
    }
}
