//
//  UIColor.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 28/10/2021.
//  Copyright © 2020 Miguel Ferrer Fornali. All rights reserved.
//

import UIKit

extension UIColor {
  convenience init(hex: String, alpha: CGFloat = 1.0) {
    var hexFormatted: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
    
    if hexFormatted.hasPrefix("#") {
      hexFormatted = String(hexFormatted.dropFirst())
    }
    
    var rgbValue: UInt64 = 0
    Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
    
    self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
              green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
              blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
              alpha: alpha)
  }
    
  var customBlack: UIColor { return UIColor(named: "CustomBlack") ?? .black }
  var customBlue: UIColor { return UIColor(named: "CustomBlue") ?? .blue }
  var customGray: UIColor { return UIColor(named: "CustomGray") ?? .gray }
  var customGreen: UIColor { return UIColor(named: "CustomGreen") ?? .green }
  var customLightBlue: UIColor { return UIColor(named: "CustomLightBlue") ?? .blue }
  var customLightGray: UIColor { return UIColor(named: "CustomLightGray") ?? .lightGray }
  var customLightGreen: UIColor { return UIColor(named: "CustomLightGreen") ?? .green }
  var customRed: UIColor { return UIColor(named: "CustomRed") ?? .red }
  var customWhite: UIColor { return UIColor(named: "CustomWhite") ?? .white }
}
