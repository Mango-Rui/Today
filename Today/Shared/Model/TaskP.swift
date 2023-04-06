//
//  Task.swift
//  Today
//
//  Created by 李瑞 on 2022/12/1.
//

import SwiftUI
import CoreData

class TaskP: NSManagedObject {

    // MARK: Core Data
    @NSManaged var id: String
    @NSManaged var name: String
    @NSManaged var isCompleted: Bool
    @NSManaged var project: Project
    @NSManaged var focuses: Set<Focus>

    var focusList: [Focus] {
        return Array(focuses)
    }

    var index: Int {
        project.tasks.index(of: self)
    }

    // MARK: SwiftUI
    var focusTime: Int {
        var total = 0
        focuses.forEach { focus in
            total += Int(focus.duration)
        }
        return total
    }
}

