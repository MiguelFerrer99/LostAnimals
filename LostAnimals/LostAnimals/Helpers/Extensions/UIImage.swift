//
//  UIImage.swift
//  OptimusPlan
//
//  Created by David Alhambra on 13/10/20.
//  Copyright © 2020 Rudo. All rights reserved.
//

import UIKit

extension UIImage {
  func convertedToGrayScale() -> UIImage? {
    let context = CIContext(options: nil)
    if let filter = CIFilter(name: "CIPhotoEffectNoir") {
      filter.setValue(CIImage(image: self), forKey: kCIInputImageKey)
      if let output = filter.outputImage {
        if let cgImage = context.createCGImage(output, from: output.extent) {
          return UIImage(cgImage: cgImage)
        }
      }
    }
    return nil
  }
}
