//
//  PostScrollView.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 13/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import Foundation
import UIKit

extension PostViewController {
  // MARK: - Functions
  func configureScrollView(_ scrollView: UIScrollView) {
    scrollView.setContentOffset(CGPoint(x: 0, y: 44), animated: true)
  }
}
