//
//  ModelData.swift
//  Today
//
//  Created by 李瑞 on 2022/11/14.
//

import SwiftUI
import Foundation

final class ModelData: ObservableObject {
    static let shared: ModelData = ModelData()
    var taskDataService = TaskDataService()
    
    @Published var tasks: [Task]    
    @Published var projects: [Project] = [
        Project(id: "0", name: "Default"),
        Project(id: "1", name: "Project1"),
        Project(id: "2", name: "Project2"),
    ]
    
    init() {
        tasks = taskDataService.tasks
    }
    
    func tasks(in project: Project) -> [Task] {
        return tasks.filter { project.id == $0.projectId }
    }
    
    
    struct TaskDataService {
        var tasks: [Task] = [
            Task(name: "task1", isCompleted: true, date: 1, focusTime: 30),
            Task(name: "task2", projectId: "1", date: 2, focusTime: 40),
            Task(name: "task3", projectId: "1", date: 1, focusTime: 100),
            Task(name: "task4", projectId: "1", date: 2, focusTime: 99999999),
            Task(name: "task5", projectId: "2", date: 1, focusTime: 300),
            Task(name: "task6", projectId: "2", date: 3, focusTime: 250),
        ]
        
        func tasks(in proejct: Project) -> [Task] {
            return tasks.filter { $0.projectId == proejct.id}
        }
        
    }
}


