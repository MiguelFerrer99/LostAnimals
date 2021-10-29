//
//  CustomView.swift
//  Chatripp
//
//  Created by Toni García Alhambra on 11/10/2019.
//  Copyright © 2019 rudo. All rights reserved.
//

import UIKit

@IBDesignable class CustomView: UIView {
  // MARK: - Inspectables
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
  
  // MARK: - Functions
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
}
