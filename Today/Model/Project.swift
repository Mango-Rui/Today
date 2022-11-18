//
//  Project.swift
//  Today
//
//  Created by 李瑞 on 2022/11/15.
//

import Foundation

struct Project: Hashable, Codable, Identifiable {
    var id: Int
    var name: String = ""
    var isCompleted: Bool = false
    var tasks: [Task] = []
    var taskCount: Int { tasks.count }
    var isShowTasksInTaskView: Bool = false
    
    static func emptyProject() -> Project {
        return Project(id: 0)
    }
    
    static func defaultProject() -> Project {
        return Project(id: 0, name: "default", isCompleted: false)
    }
    
    static func == (lhs: Project, rhs: Project) -> Bool {
        lhs.id == rhs.id
    }
}
