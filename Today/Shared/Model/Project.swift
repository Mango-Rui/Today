//
//  Project.swift
//  Today
//
//  Created by 李瑞 on 2022/11/15.
//

import Foundation
import CoreData
import SwiftUI

class Project: NSManagedObject {

    @NSManaged var id: String
    @NSManaged var name: String
    @NSManaged var isCompleted: Bool
    @NSManaged var flag: Int16
    @NSManaged var tasks: NSOrderedSet
    @NSManaged var createTime: Date

    var focusTime: Int {
        var total: Int = 0
        self.tasks.forEach { task in
            if let task = task as? TaskP {
                total += task.focusTime
            }
        }
        return total
    }

    var mutableTasks: NSMutableOrderedSet {
        return NSMutableOrderedSet(orderedSet: tasks)
    }

    var taskList: [TaskP] {
        return tasks.array as! [TaskP]
    }

    var properties: ProjectProperties {
        var properties = ProjectProperties()
        properties.id = id
        properties.name = name
        properties.tasks = tasks
        properties.flag = flag
        properties.isCompleted = isCompleted
        return properties
    }

    static func create(properties: ProjectProperties, context: NSManagedObjectContext) -> Project {
        let project = Project(context: context)
        project.name = properties.name
        project.flag = properties.flag
        project.isCompleted = false
        project.id = UUID().uuidString
        project.createTime = properties.createTime
        try?context.save()
        return project
    }

    func updateProject(properties: ProjectProperties) {

    }
}


// MARK: - SwiftUI
extension Project {
    var color: Color {
        switch flag {
            case 0:
                return .gray
            case 1:
                return .purple
            case 2:
                return .yellow
            case 3:
                return .orange
            case 4:
                return .red
            case 5:
                return .orange
            default:
                return .gray
        }
    }
}

// MARK: - Tasks
extension Project {

    func addTask(_ task: TaskP) {
        mutableTasks.add(task)
        tasks = mutableTasks
    }

    func deleteTask(_ task: TaskP) {
        mutableTasks.remove(task)
        tasks = mutableTasks
    }

    func moveTask(from source: Int, to destination: Int) {
        var array = tasks.array as! [TaskP]
        let task = array.remove(at: source)
        array.insert(task, at: destination)
        tasks = NSOrderedSet(array: array)
    }
}

// MARK: - Fetch
extension Project {
    static func getAllProjectsFetchRequest() -> NSFetchRequest<Project> {
        let request = NSFetchRequest<Project>(entityName: "Project")
        request.sortDescriptors = []
        return request
    }
}


// MARK: - Properties
struct ProjectProperties {
    var id: String = ""
    var name: String = ""
    var isCompleted: Bool = false
    var flag: Int16 = -1
    var tasks: NSOrderedSet = []
    var createTime: Date = Date()

    static var empty: ProjectProperties {
        return ProjectProperties()
    }

}
