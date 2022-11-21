//
//  TaskRow.swift
//  Today
//
//  Created by 李瑞 on 2022/11/14.
//

import SwiftUI


struct TaskRow: View {
    @EnvironmentObject var modelData: ModelData
    @Namespace var namespace
    var task: Task
    @AppStorage("showClock") var showClock = false
    @AppStorage("currentTask") var currentTask = ""


    var taskIndex: Int {
        modelData.tasks.firstIndex(of: task)!
    }
    
    var body: some View {
        HStack {
            NavigationLink {
                TaskDetail(task: task)
            } label: {
                HStack {
                    playBtn
                        .padding(.top, 8)
                    VStack(alignment: .leading, spacing: 4) {
                        Text(task.name)
                        Text("\(task.focusTime) min")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                    }
                    .multilineTextAlignment(.leading)
                    
                }
            }
            .swipeActions(allowsFullSwipe: false) {
                checkBtn
                deleteBtn
            }
        }
    }
    
    
    var checkBtn: some View {
        Button {
            modelData.tasks[taskIndex].isCompleted.toggle()
        } label: {
            Label("complete", systemImage: task.isCompleted ? "gobackward" : "checkmark")
        }
        .tint(task.isCompleted ? .purple : .green)
    }
    
    var playBtn: some View {
        VStack {
            Image(systemName: task.isCompleted ? "checkmark.circle" : "play.circle")
                .foregroundColor(task.isCompleted ? Color.green : Color.purple)
                .imageScale(.large)
            Spacer()
        }
        .onTapGesture {
            showClock.toggle()
            currentTask = self.task.id
        }
    }
    
    var deleteBtn: some View {
        Button{
            modelData.tasks.remove(at: taskIndex)
        } label: {
            Label("Delete", systemImage: "trash")
        }
        .tint(.red)
    }
}



struct TaskRow_Previews: PreviewProvider {
    static let modelData = ModelData()

    static var previews: some View {
        let task = modelData.tasks[0]
        TaskRow(task: task)
    }
}
