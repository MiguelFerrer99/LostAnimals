//
//  CustomStackView.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 9/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

@IBDesignable class CustomStackView: UIStackView {
    // MARK: - IBInspectables
    @IBInspectable var cornerRadius: CGFloat = 0 {
        willSet {
            setCornerRadius(of: newValue)
        }
    }
}

// MARK: - Functions
extension CustomStackView {
    func setCornerRadius(of radius: CGFloat) {
        self.layer.cornerRadius = radius
    }
}
