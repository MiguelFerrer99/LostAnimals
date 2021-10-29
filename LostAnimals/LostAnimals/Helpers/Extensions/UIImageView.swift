//
//  UIImageView.swift
//  El Pibe
//
//  Created by Aharon on 17/5/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

extension UIImageView {

  func setURLImage(_ url: String) {
    let placeholderImage = UIImage(named: "placeholder")

    if let _ = URL(string: url) {
      self.image = UIImage()
      self.backgroundColor = .clear
    } else {
      self.image = placeholderImage
      self.backgroundColor = .clear
    }
  }
}

