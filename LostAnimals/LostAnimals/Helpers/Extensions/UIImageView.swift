//
//  UIImageView.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 28/10/2021.
//  Copyright © 2020 Miguel Ferrer Fornali. All rights reserved.
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

