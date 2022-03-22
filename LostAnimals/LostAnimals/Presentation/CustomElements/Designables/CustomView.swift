//
//  CustomView.swift
//  Chatripp
//
//  Created by Toni García Alhambra on 11/10/2019.
//  Copyright © 2019 rudo. All rights reserved.
//

import UIKit

@IBDesignable class CustomView: UIView {
    // MARK: - IBInspectables
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
    @IBInspectable var shadowColor: UIColor = .clear {
        willSet {
            setBorderColor(newValue)
        }
    }
    @IBInspectable var shadowOffset: CGSize = .zero {
        willSet {
            setShadowOffset(newValue)
        }
    }
    @IBInspectable var shadowRadius: CGFloat = .zero {
        willSet {
            setShadowRadius(newValue)
        }
    }
    @IBInspectable var shadowOpacity: Float = .zero {
        willSet {
            setShadowOpacity(newValue)
        }
    }
}

// MARK: - Functions
extension CustomView {
    func round(_ round: Bool) {
        self.layer.cornerRadius = round ? self.frame.width / 2 : cornerRadius
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
    
    func setShadowColor(_ color: UIColor) {
        self.layer.shadowColor = color.cgColor
    }
    
    func setShadowOffset(_ cgSize: CGSize) {
        self.layer.shadowOffset = cgSize
    }
    
    func setShadowRadius(_ radius: CGFloat) {
        self.layer.shadowRadius = radius
    }
    
    func setShadowOpacity(_ opacity: Float) {
        self.layer.shadowOpacity = opacity
    }
}
