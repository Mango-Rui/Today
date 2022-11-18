//
//  TaskEditorConfig.swift
//  Today
//
//  Created by 李瑞 on 2022/11/14.
//

import Foundation

struct TaskEditorConfig {
    var task = Task.emptyTask()
    var shouldSaveChanges = false
    var isPresented = false
    
    mutating func presentEditTask(_ taskToEdit: Task) {
        task = taskToEdit
        shouldSaveChanges = true
        isPresented = true
    }
    
    mutating func done() {
        shouldSaveChanges = true
        isPresented = false
    }
    
    mutating func cancel() {
        shouldSaveChanges = false
        isPresented = false
    }
}
