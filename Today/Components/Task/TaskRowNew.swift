//
//  TaskRowNew.swift
//  Today
//
//  Created by 李瑞 on 2022/11/14.
//

import SwiftUI

struct TaskRowNew: View {
    @EnvironmentObject var modelData: ModelData
    @State var newTaskName: String = ""
    var project: Project
    
    var body: some View {
        HStack {
            Image(systemName: "circle")
                .foregroundColor(Color(.systemGray3))
                .imageScale(.large)
            TextField("New Task", text: $newTaskName)
                .onSubmit {
                    var newTask = Task.emptyTask()
                    newTask.name = newTaskName
                    newTask.projectId = project.id
                    modelData.tasks.append(newTask)
                    newTaskName = ""
                }
                .textInputAutocapitalization(.never)
        }
    }
}

struct TaskRowNew_Previews: PreviewProvider {
    static let modelData = ModelData()
    static var previews: some View {
        TaskRowNew(project: modelData.projects[0])
    }
}
