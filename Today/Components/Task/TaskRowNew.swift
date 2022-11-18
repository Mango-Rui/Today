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
    var project: Project = Project.defaultProject()
    
    var body: some View {
        HStack {
            Image(systemName: "circle")
                .foregroundColor(Color(.systemGray3))
                .imageScale(.large)
            TextField("New Task", text: $newTaskName)
                .onSubmit {
                    modelData.tasks.append(
                        Task(name: self.newTaskName, projectId: project.id)
                    )
                    newTaskName = ""
                }
                .textInputAutocapitalization(.never)
        }
    }
}

struct TaskRowNew_Previews: PreviewProvider {
    static var previews: some View {
        TaskRowNew()
    }
}
