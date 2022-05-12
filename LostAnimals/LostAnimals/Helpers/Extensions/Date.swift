//
//  Date.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 28/10/2021.
//  Copyright © 2020 Miguel Ferrer Fornali. All rights reserved.
//

import UIKit

extension Date {
    // MARK: - Init
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
    
    // MARK: - Properties
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
    var isCurrentMonth: Bool {
        return year == Date().year && month == Date().month
    }
    var isToday: Bool {
        return year == Date().year && month == Date().month && day == Date().day
    }
    var isYesterday: Bool {
        return year == Date().year && month == Date().month && day == Date().day - 1
    }
    var isTomorrow: Bool {
        return year == Date().year && month == Date().month && day == Date().day + 1
    }
}

// MARK: - Functions
extension Date {
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

// MARK: - DateFormat
struct DateFormat {
    static let backend = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
    static let full = "yyyy/MM/dd HH:mm:ss"
    static let dayMonthYear = "d/MM/yyyy"
    static let dayMonthYearHyphen = "dd-MM-yyyy"
    static let dayMonthYearOther = "dd/MM/yyyy"
    static let dayMonthYearHourOther = "dd/MM/yyyy HH:mm"
    static let dayMonthYearShort = "dd/MM/yy"
    static let yearMonthDay = "yyyy/MM/dd"
    static let hourMinutes = "HH:mm"
    static let minuteSeconds = "mm:ss"
    static let yearMonthDayBackend = "yyyy-MM-dd"
    static let dayMonth = "d/MM"
    static let dayMonthOther = "dd MMM"
    static let dayMonthYearHour = "dd-MM-yyyy HH:mm:ss"
    static let yearMonthDayHyphen = "yyyy-MM-dd"
}
