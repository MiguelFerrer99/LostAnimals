//
//  Date.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 28/10/2021.
//  Copyright © 2020 Miguel Ferrer Fornali. All rights reserved.
//

import Foundation

extension Date {
  init(day: Int, month: Int, year: Int, hour: Int, minute: Int) {
    self.init()
    
    let gregorianCalendar = NSCalendar(calendarIdentifier: .gregorian)!
    
    var dateComponents = DateComponents()
    dateComponents.year = year
    dateComponents.month = month
    dateComponents.day = day
    dateComponents.hour = hour
    dateComponents.minute = minute
    
    self = gregorianCalendar.date(from: dateComponents)!
  }
  
  var day: Int {
    let calendar = Calendar.current
    return calendar.component(.day, from: self)
  }
  
  var month: Int {
    let calendar = Calendar.current
    return calendar.component(.month, from: self)
  }
  
  var year: Int {
    let calendar = Calendar.current
    return calendar.component(.year, from: self)
  }
  
  var stringMonth: String {
    let dateFormatter = DateFormatter()
    dateFormatter.setLocalizedDateFormatFromTemplate("MMMM")
    return dateFormatter.string(from: self)
  }
  
  var monthStringCode: String {
    let dateFormatter = DateFormatter()
    dateFormatter.setLocalizedDateFormatFromTemplate("MMM")
    return dateFormatter.string(from: self)
  }
  
  func toString(withFormat format: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    return dateFormatter.string(from: self)
  }
  
  func timeAgoFromNow() -> String {
    let formatter = RelativeDateTimeFormatter()
    formatter.unitsStyle = .full
    formatter.locale = Locale(identifier: Locale.preferredLanguages.first ?? "en-EN")
    return formatter.localizedString(for: self, relativeTo: Date())
  }
}
