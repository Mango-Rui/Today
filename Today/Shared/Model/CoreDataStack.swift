//
//  CoreDataStack.swift
//  Today
//
//  Created by 李瑞 on 2022/12/6.
//

import CoreData

class CoreDataStack: ObservableObject {

    // MARK: Core Data
    private let container: NSPersistentContainer

    var viewContext: NSManagedObjectContext {
        container.viewContext
    }

    init() {
        container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Error loading core data: \(error)")
            } else {
                print("Successfully loaded core data.")
            }
        }
    }

    func whereIsMySQLite() {
        let path = NSPersistentContainer
            .defaultDirectoryURL()
            .absoluteString
            .replacingOccurrences(of: "file://", with: "")
            .removingPercentEncoding

        print(path ?? "Not found")
    }

    // MARK: Project
    func addProject(properties: ProjectProperties) -> Project {
        let project = Project(context: viewContext)
        project.name = properties.name
        project.flag = properties.flag
        project.isCompleted = false
        project.id = UUID().uuidString
        viewContext.saveChanges()
        return project
    }

    func deleteProject(project: Project) {
        viewContext.perform {
            self.viewContext.delete(project)
        }
        viewContext.saveChanges()
    }

    func updateProject(project: Project, properties: ProjectProperties) async -> Project {
        await viewContext.perform {
            project.name = properties.name
            project.flag = properties.flag
        }
        viewContext.saveChanges()
        return project
    }

    func updateProjectFlag(flag: Int16, project: Project) {
        viewContext.perform {
            project.flag = flag
        }
        viewContext.saveChanges()
    }

    // MARK: Task
    func addTasks() {
        guard UserDefaults.standard.bool(forKey: "addTaskFlag") == false else {
            return
        }
        UserDefaults.standard.set(true, forKey: "addTaskFlag")
    }

    func addTask(name: String, project: Project) {
        let task = TaskP(context: viewContext)
        task.id = UUID().uuidString
        task.name = name
        task.project = project
        viewContext.saveChanges()
    }

    func addTasksToProject(names: [String], project: Project) {
        for name in names {
            let task = TaskP(context: viewContext)
            task.id = UUID().uuidString
            task.name = name
            task.project = project
        }
        viewContext.saveChanges()
    }

    func deleteTask(task: TaskP, project: Project) {
        viewContext.perform {
            self.viewContext.delete(task)
        }
        viewContext.saveChanges()
    }

    // MARK: Focus
    func addFocus(startTime: Date, duration: Int16, task: TaskP) {
        let focus = Focus(context: viewContext)
        focus.id = UUID().uuidString
        focus.startTime = startTime
        focus.duration = duration
        focus.task = task
        viewContext.saveChanges()
    }

    func deleteFocus(focus: Focus) {
        viewContext.perform {
            self.viewContext.delete(focus)
        }
        viewContext.saveChanges()
    }
}
