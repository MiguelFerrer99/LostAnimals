//
//  CustomImageView.swift
//  Chatripp
//
//  Created by Toni García Alhambra on 14/10/2019.
//  Copyright © 2019 rudo. All rights reserved.
//

import UIKit

@IBDesignable class CustomImageView: UIImageView {
    // MARK: - IBInspectables
    @IBInspectable var color: UIColor = .black {
        willSet {
            setColor(newValue)
        }
    }
    @IBInspectable var fullRound: Bool = false {
        willSet {
            round(newValue)
        }
    }
    @IBInspectable var cornerRadius: CGFloat = 0 {
        willSet {
            setCornerRadius(of: newValue)
        }
    }
    @IBInspectable var borderWidth: CGFloat = 0 {
        willSet {
            setBorderWidth(newValue)
        }
    }
    @IBInspectable var borderColor: UIColor = .clear {
        willSet {
            setBorderColor(newValue)
        }
    }
}

// MARK: - Functions
extension CustomImageView {
    func setColor(_ color: UIColor) {
        let image = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = image
        
        self.tintColor = color
    }
    
    func round(_ round: Bool) {
        self.layer.cornerRadius = round ? self.frame.height / 2 : cornerRadius
    }
    
    func setCornerRadius(of radius: CGFloat) {
        if fullRound { return }
        self.layer.cornerRadius = radius
    }
    
    func setBorderWidth(_ borderWidth: CGFloat) {
        self.layer.borderWidth = borderWidth
    }
    
    func setBorderColor(_ color: UIColor) {
        self.layer.borderColor = color.cgColor
    }
}
