//
//  UIImage.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 28/10/2021.
//  Copyright © 2020 Miguel Ferrer Fornali. All rights reserved.
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
  
  func drawImageIn(bgImage: UIImage, position: CGRect) -> UIImage? {
    UIGraphicsBeginImageContext(bgImage.size)
    bgImage.draw(in: CGRect(x: 0, y: 0, width: bgImage.size.width, height: bgImage.size.height))
    self.draw(in: position, blendMode: .normal, alpha: 1)
    let returnedImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return returnedImage
  }
}
