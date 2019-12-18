//
//  DateTime.swift
//  Appetit_app_iOS
//
//  Created by Marcos Joshoa on 12/12/19.
//  Copyright © 2019 Marcos Joshoa. All rights reserved.
//

import Foundation

public class DateTime: NSObject, NSCoding, Codable {
    
    var year: Int32
    var month: Int32
    var dayOfMonth: Int32
    var hourOfDay: Int32?
    var minute: Int32?
    var second: Int32?
    
    init(_ year: Int32, _ month: Int32, _ dayOfMonth: Int32, _ hourOfDay: Int32?, _ minute: Int32?, _ second: Int32?) {
        self.year = year
        self.month = month
        self.dayOfMonth = dayOfMonth
        self.hourOfDay = hourOfDay
        self.minute = minute
        self.second = second
        super.init()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        self.year = aDecoder.decodeInt32(forKey: "year")
        self.month = aDecoder.decodeInt32(forKey: "month")
        self.dayOfMonth = aDecoder.decodeInt32(forKey: "dayOfMonth")
        self.hourOfDay = aDecoder.decodeObject(forKey: "hourOfDay") as? Int32
        self.minute = aDecoder.decodeObject(forKey: "minute") as? Int32
        self.second = aDecoder.decodeObject(forKey: "second") as? Int32
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(year, forKey: "year")
        aCoder.encode(month, forKey: "month")
        aCoder.encode(dayOfMonth, forKey: "dayOfMonth")
        aCoder.encode(hourOfDay, forKey: "hourOfDay")
        aCoder.encode(minute, forKey: "minute")
        aCoder.encode(second, forKey: "second")
        
    }
    
    public func getDateTime() -> Date? {
        var dateComponents = DateComponents()
        dateComponents.year = Int(self.year)
        dateComponents.month = Int(self.month)
        dateComponents.day = Int(self.dayOfMonth)
        dateComponents.timeZone = TimeZone(abbreviation: "BRT")
        dateComponents.hour = Int(self.hourOfDay!)
        dateComponents.minute = Int(self.minute!)
        dateComponents.second = Int(self.second!)
        
        let userCalendar = Calendar.current
        return userCalendar.date(from: dateComponents)
    }
    
    public static func createCustomeDate(year: Int = 0, month: Int = 0, day: Int = 0, hour: Int = 0, minute: Int = 0, second: Int = 0) -> Date {
        let date = Date()
        let userCalendar = Calendar.current
        var dateComponents = DateComponents()
        if year == 0 {
            dateComponents.year = userCalendar.component(.year, from: date)
            dateComponents.month = userCalendar.component(.month, from: date)
            dateComponents.day = userCalendar.component(.day, from: date)
        } else {
            dateComponents.year = year
            dateComponents.month = month
            dateComponents.day = day
        }
        dateComponents.timeZone = TimeZone(secondsFromGMT: TimeZone.current.secondsFromGMT())
        dateComponents.hour = hour
        dateComponents.minute = minute
        dateComponents.second = second
        return userCalendar.date(from: dateComponents)!
    }
    
    public func toString(_ format: String = Strings.dateTimeFormat) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "pt-br")
        formatter.dateFormat = format
        return formatter.string(from:  getDateTime()!)
    }
    
    static func dateToString(_ date: Date, _ format: String = Strings.dateTimeFormat2) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "pt-br")
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
    static func getCurrentDateTime() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "pt-br")
        formatter.dateFormat = Strings.dateTimeFormat
        return formatter.string(from: Date())
    }
    
    static func getCurrentDate() -> DateTime {
        let date = Date()
        let userCalendar = Calendar.current
        return DateTime(Int32(userCalendar.component(.year, from: date)), Int32(userCalendar.component(.month, from: date)), Int32(userCalendar.component(.day, from: date)), Int32(userCalendar.component(.hour, from: date)), Int32(userCalendar.component(.minute, from: date)), Int32(userCalendar.component(.second, from: date)))
    }
}
