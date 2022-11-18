//
//  TaskView.swift
//  Today
//
//  Created by 李瑞 on 2022/11/15.
//

import SwiftUI

struct TaskView: View {
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        NavigationStack {
            List($modelData.projects) { $project in
                Section {
                    if project.isShowTasksInTaskView {
                        ForEach($modelData.tasks) { $task in
                            TaskRow(task: $task)
                        }
                        TaskRowNew(project: project)
                    }
                    
                } header: {
                    SectionHeader(project: $project)
                }
            }
            .navigationTitle("Tasks")
        }
        
    }
}

private struct SectionHeader: View {
    @Binding var project: Project
    
    var body: some View {
        HStack() {
            Text(project.name)
                .foregroundColor(.primary)
                .bold()
                .font(.title3)
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
            Button {
                withAnimation() {
                    project.isShowTasksInTaskView.toggle()
                }
            } label: {
                Image(systemName: project.isShowTasksInTaskView ? "chevron.down" : "chevron.right")
            }
        }
        .padding(.leading, -20)
        
        
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView()
            .environmentObject(ModelData())
    }
}
