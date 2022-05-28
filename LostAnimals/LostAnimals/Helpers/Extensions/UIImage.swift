//
//  UIImage.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 28/10/2021.
//  Copyright © 2020 Miguel Ferrer Fornali. All rights reserved.
//

import UIKit

// MARK: - Functions
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
    
    func isEqualTo(image: UIImage?) -> Bool {
        guard let nsData1 = self.pngData(),
              let image = image,
              let nsData2 = image.pngData()
        else { return false }
        return nsData1 == nsData2
    }
    
    func croppedRectImage() -> UIImage? {
        let sideLength = min(
            self.size.width,
            self.size.height
        )
        let sourceSize = self.size
        let xOffset = (sourceSize.width - sideLength) / 2.0
        let yOffset = (sourceSize.height - sideLength) / 2.0
        let cropRect = CGRect(
            x: xOffset,
            y: yOffset,
            width: sideLength,
            height: sideLength
        ).integral
        guard let sourceCGImage = self.cgImage,
                let croppedCGImage = sourceCGImage.cropping(to: cropRect)
        else { return nil }
        let croppedImage = UIImage(
            cgImage: croppedCGImage,
            scale: self.imageRendererFormat.scale,
            orientation: self.imageOrientation
        )
        return croppedImage
    }
}
