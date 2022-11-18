//
//  Project.swift
//  Today
//
//  Created by 李瑞 on 2022/11/15.
//

import Foundation

struct Project: Hashable, Codable, Identifiable {
    var id: String = UUID().uuidString
    var name: String = ""
    var isCompleted: Bool = false
    var tasks: [Task] = []
    var taskCount: Int { tasks.count }
    
    
    static func emptyProject() -> Project {
        return Project()
    }
    
    static func createByName(name: String) -> Project {
        var project = Project()
        project.name = name
        return project
    }
    
    static func == (lhs: Project, rhs: Project) -> Bool {
        lhs.id == rhs.id
    }
}
