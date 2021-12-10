//
//  String.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 28/10/2021.
//  Copyright © 2020 Miguel Ferrer Fornali. All rights reserved.
//

import Foundation

extension String {
  var localized: String {
    return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
  }
  
  func isValidEmail() -> Bool {
    let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
    return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
  }
  
  func isValidPassword() -> Bool {
    let regex = try! NSRegularExpression(pattern: "^(?=.*[0-9])(?=.*[A-Z]).{8,32}$", options: .caseInsensitive)
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
  
  func isValidDate() -> Bool {
    let regex = try! NSRegularExpression(pattern: "^([0-2][0-9]|(3)[0-1])(/)(((0)[0-9])|((1)[0-2]))(/)[0-9]{4}$", options: .caseInsensitive)
    return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
  }
  
  func toDate(withFormat format: String)-> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.calendar = Calendar(identifier: .gregorian)
    dateFormatter.dateFormat = format
    let date = dateFormatter.date(from: self)
    
    return date
  }
}
