//
//  DateTime.swift
//  App
//
//  Created by Shahzaib Ali on 02/08/2024.
//

import Foundation


class DateTime {

    static let shared = DateTime()
    private let TAG = "DateTime"

    
    func getTimeZoneOffset() -> Int {
        let timeZone = TimeZone.current
        let secondsFromGMT = timeZone.secondsFromGMT()
        let hours = secondsFromGMT / 3600
        return hours
    }
    var currentDateTimeActual: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.locale = Locale(identifier: "en")
        return formatter.string(from: Date())
    }

    var currentDateTime: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.locale = Locale(identifier: "en")

        // Get the current date
        let currentDate = Date()
        
        // Use Calendar to get the start of the day
        let startOfDay = Calendar.current.startOfDay(for: currentDate)
        
        return formatter.string(from: startOfDay)
    }

    
    private func toAdjustedOffsetHours(dateString: String?) -> Date
    {
        guard let dateString = dateString, let date = parseDate(dateString: dateString) else {
            return  Date()
        }

        // Get the time zone offset in hours
        let offSetHours = getTimeZoneOffset()
        
        // Create a calendar to manipulate the date
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!

        // Adjust the date with the offset
        let adjustedDate = calendar.date(byAdding: .hour, value: offSetHours, to: date)
        return adjustedDate ?? date
    }
    
    func currentAmPm() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h a"
        return formatter.string(from:Date())
    }
    func convertToAmPm(dateString: String?) -> String {
     
        let date = toAdjustedOffsetHours(dateString: dateString)
        let formatter = DateFormatter()
        formatter.dateFormat = "h a"
//        formatter.locale = Locale(identifier: "en_US") // You can use a different locale if needed
        return formatter.string(from:date)
    }

    func toDayName(dateString: String?) -> String {
        let date = toAdjustedOffsetHours(dateString: dateString)
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
//        formatter.locale = Locale(identifier: "time_zone".toLocalizedString())
        return formatter.string(from: date)
    }

    func toShortDate(dateString: String?) -> String {
        let date = toAdjustedOffsetHours(dateString: dateString)
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM"
//        formatter.locale = Locale(identifier: "time_zone".toLocalizedString())
        return formatter.string(from: date)
    }

    func addDays(days: Int) -> String {
        let formatter = DateFormatter()
           formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
           formatter.timeZone = TimeZone(abbreviation: "UTC")
           formatter.locale = Locale(identifier: "en")
           let calendar = Calendar.current
           
           // Get the current date
           let currentDate = Date()
           
           // Get the start of the current day
           let startOfDay = calendar.startOfDay(for: currentDate)
           
           // Add the specified number of days to the start of the current day
           let newDate = calendar.date(byAdding: .day, value: days, to: startOfDay)!
           
           return formatter.string(from: newDate)
    }

    private func parseDate(dateString: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
//        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter.date(from: dateString)
    }
}
