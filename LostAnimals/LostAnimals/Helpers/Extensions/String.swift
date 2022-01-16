//
//  String.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 28/10/2021.
//  Copyright © 2020 Miguel Ferrer Fornali. All rights reserved.
//

import Foundation
import UIKit

extension String {
  var localized: String {
    return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
  }
  
  func isValidEmail() -> Bool {
    let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
    return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
  }
  
  func isValidPassword() -> Bool {
    let regex = try! NSRegularExpression(pattern: "^(?=.*[a-z])(?=.*[0-9]).{8,}$", options: .caseInsensitive)
    return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
  }
  
  func areOnlyLetters() -> Bool {
    let regex = try! NSRegularExpression(pattern: "^([A-Za-z]+)$", options: .caseInsensitive)
    return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
  }
  
  func areOnlyLettersAndSpaces() -> Bool {
    let regex = try! NSRegularExpression(pattern: "^([A-Za-z ]+)$", options: .caseInsensitive)
    return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
  }
  
  func isValidPhoneNumber() -> Bool {
    let regex = try! NSRegularExpression(pattern: "^([0-9]{1,12})$", options: .caseInsensitive)
    return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
  }
  
  func isValidTwitterUsername() -> Bool {
    let regex = try! NSRegularExpression(pattern: "^[a-z0-9_]*$", options: .caseInsensitive)
    return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
  }
  
  func isValidInstagramUsername() -> Bool {
    let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9._]*$", options: .caseInsensitive)
    return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
  }
  
  func toDate(withFormat format: String)-> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.calendar = Calendar(identifier: .gregorian)
    dateFormatter.dateFormat = format
    let date = dateFormatter.date(from: self)
    
    return date
  }
  
  func drawTextIn(bgImage: UIImage, position: CGRect, textAttributes: [NSAttributedString.Key: Any]) -> UIImage? {
    let nsString = NSString(string: self)
    UIGraphicsBeginImageContext(bgImage.size)
    bgImage.draw(in: CGRect(x: 0, y: 0, width: bgImage.size.width, height: bgImage.size.height))
    nsString.draw(in: position, withAttributes: textAttributes)
    let returnedImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return returnedImage
  }
}
