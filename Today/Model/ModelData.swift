//
//  ModelData.swift
//  Today
//
//  Created by 李瑞 on 2022/11/14.
//

import Foundation

final class ModelData: ObservableObject {
    static let shared: ModelData = ModelData()
    var taskDataService = TaskDataService()
    
    @Published var tasks: [Task]
    
    @Published var projects: [Project] = [
        Project(id: 0, name: "default"),
        Project(id: 1, name: "project1"),
        Project(id: 2, name: "project2"),
    ]
    
    init() {
        tasks = taskDataService.tasks
    }
    
    func tasks(in project: Project) -> [Task] {
        return tasks.filter{ project.id == $0.projectId }
    }
    
    
    struct TaskDataService {
        var tasks: [Task] = [
            Task(name: "task1", isCompleted: true),
            Task(name: "task2", projectId: 1),
            Task(name: "task3", projectId: 1),
            Task(name: "task4", projectId: 1),
            Task(name: "task5", projectId: 2),
            Task(name: "task6", projectId: 2),
        ]
        
        func tasks(in proejct: Project) -> [Task] {
            return tasks.filter { $0.projectId == proejct.id}
        }
        
    }
}


