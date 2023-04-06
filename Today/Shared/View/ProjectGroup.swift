//
//  ProjectGroup.swift
//  Today
//
//  Created by 李瑞 on 16/3/2023.
//

import SwiftUI

struct ProjectGroup: View {
    @EnvironmentObject var coreDataStack: CoreDataStack
    var project: Project

    var body: some View {
        Section {
            ForEach(project.taskList, id: \.id) { task in
                    TaskRow(task: task)
            }
            .onMove { (indexSet, index) in
                guard let sourceIndex = indexSet.first else { return }
                project.moveTask(from: sourceIndex, to: index)
            }
            .onDelete(perform: { indexSet in
                if let firstIndex = indexSet.first {
                    let task = project.taskList[firstIndex]
                    coreDataStack.deleteTask(task: task, project: project)
                }
            })

            TaskRowNew(project: project)
        } header: {
            HStack() {
                Text(project.name)
                    .foregroundColor(.primary)
                    .font(.title3.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)

                Spacer()

                NavigationLink {
                    ProjectDetail(project: project, isNew: false)
                } label: {
                    if let colorEnum = FlagColorEnum(rawValue: project.flag) {
                        Image(systemName: "folder")
                            .foregroundColor(colorEnum.color)
                    } else {
                        Image(systemName: "folder")
                            .foregroundColor(.gray)
                    }
                }
            }
        }
        .textCase(.none)
    }
}


