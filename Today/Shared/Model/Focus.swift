//
//  Period.swift
//  Today
//
//  Created by 李瑞 on 2022/11/21.
//

import Foundation
import CoreData

class Focus: NSManagedObject {
    @NSManaged var id: String
    @NSManaged var duration: Int16
    @NSManaged var startTime: Date
    @NSManaged var task: TaskP

    var endTime: Date {
        return startTime.addingTimeInterval(Double(duration * 60))
    }

    var isDay: Bool {
        let components = Calendar.current.dateComponents([.hour], from: startTime)
        return (6...18).contains(components.hour ?? 7)
    }

    var imageName: String {
        isDay ? "sun.max.fill" : "moon.fill"
    }

}

// MARK: - Fetch Request
extension Focus {
    static func getFocusList(of task: TaskP) -> NSFetchRequest<Focus> {
        let request = Focus.fetchRequest() as! NSFetchRequest<Focus>
        request.sortDescriptors = [NSSortDescriptor(key: "startTime", ascending: false)]
        request.predicate = NSPredicate(format: "task = %@", task)
        return request
    }

    static func weekPredicate() -> NSPredicate {
        let weekBoundary = Calendar.weekBoundary(for: Date())
        let startOfDay = weekBoundary.startOfWeek
        let endOfDay = weekBoundary.endOfWeek
        let format = "(startTime >= %@) AND (startTime <= %@)"
        let predicate = NSPredicate(format: format, startOfDay as CVarArg, endOfDay as CVarArg)
        return predicate
    }

}

