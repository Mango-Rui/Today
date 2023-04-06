//
//  Extensions.swift
//  Today
//
//  Created by 李瑞 on 6/3/2023.
//

import Foundation
import CoreData

extension NSManagedObjectContext {
    func saveChanges() {
        guard self.hasChanges else { return }
        do {
            try self.save()
        } catch {
            self.rollback()
            print("Error saveing core data: \(error)")
        }
    }
}

extension Date {
    static func from(year: Int, month: Int, day: Int) -> Date {
        let components = DateComponents(year: year, month: month, day: day)
        return Calendar.current.date(from: components)!
    }

    static var monday: Date {
        let calendar = Calendar.current
        let today = Date()
        let weekday = calendar.component(.weekday, from: today)
        let daysToManday = (7 + calendar.firstWeekday - weekday) % 7
        let monday = calendar.date(byAdding: .day, value: daysToManday, to: today)!

        let components = calendar.dateComponents([.year, .month, .day], from: monday)
        let startOfDay = calendar.date(from: components)!

        return startOfDay
    }

    static var sunday: Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .day, value: 6, to: monday)!
    }

    static func startOfDay(for date: Date) -> Date {
        let calendar = Calendar.calendar()
        let startOfToday = calendar.date(bySettingHour: 0, minute: 0, second: 0, of: date)!
        return startOfToday
    }

    static func endOfDay(for date: Date) -> Date {
        let calendar = Calendar.calendar()
        let endOfToday = calendar.date(bySettingHour: 23, minute: 59, second: 59, of: date)!
        return endOfToday
    }
}

extension Calendar {
    typealias WeekBoundary = (startOfWeek: Date, endOfWeek: Date)
    typealias DayBoundary = (startOfDay: Date, endOfDay: Date)

    static func calendar() -> Calendar {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "UTC")!
        return calendar
    }

    static func weekBoundary(for date: Date) -> WeekBoundary {
        let calendar = Calendar.calendar()
        let today = calendar.startOfDay(for: date)
        let components = calendar.dateComponents([.weekday], from: today)
        let daysToMonday = (components.weekday! + 5) % 7 + 1
        let monday = calendar.date(byAdding: .day, value: -daysToMonday, to: today)!
        let startOfWeek = calendar.date(bySettingHour: 0, minute: 0, second: 0, of: monday)!
        let sunday = calendar.date(byAdding: .day, value: 6, to: startOfWeek)!
        let endOfWeek = calendar.date(bySettingHour: 23, minute: 59, second: 59, of: sunday)!
        return (startOfWeek, endOfWeek)
    }

    static func dayBoundary(for date: Date) -> DayBoundary {
        let calendar = Calendar.calendar()
        let startOfDay = calendar.date(bySettingHour: 0, minute: 0, second: 0, of: date)!
        let endOfDay = calendar.date(bySettingHour: 23, minute: 59, second: 59, of: date)!
        return (startOfDay, endOfDay)
    }
}

