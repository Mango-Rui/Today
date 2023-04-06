//
//  TaskRowNew.swift
//  Today
//
//  Created by 李瑞 on 2022/12/22.
//

import SwiftUI

struct TaskRowNew: View {
    @EnvironmentObject var coreDataStack: CoreDataStack
    @State var newTaskName = ""

    var project: Project

    var body: some View {
        HStack {
            Image(systemName: "plus")
                .foregroundColor(Color(.systemGray3))
                .imageScale(.large)
            TextField("New Task", text: $newTaskName)
                .onSubmit {
                    guard !newTaskName.isEmpty else { return }
                    coreDataStack.addTask(name: newTaskName, project: project)
                    newTaskName = ""
                }
                .textInputAutocapitalization(.never)
        }
    }
}

//struct TaskRowNew_Previews: PreviewProvider {
//    static var previews: some View {
//        TaskRowNew()
//    }
//}
