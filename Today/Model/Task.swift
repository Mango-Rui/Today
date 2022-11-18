//
//  Task.swift
//  Today
//
//  Created by 李瑞 on 2022/11/14.
//

import Foundation

struct Task: Hashable, Codable, Identifiable {
    var id: UUID = UUID()
    var name: String = ""
    var isCompleted: Bool = false
    var projectId: Int = 0
    var focusTime: Int = 0
    
    
    static func emptyTask() -> Task {
        return Task()
    }
}
