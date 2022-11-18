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
    @Binding var task: Task
    
    var taskIndex: Int {
        modelData.tasks.firstIndex(of: task)!
    }
    
    var body: some View {
        HStack {
            NavigationLink {
                TaskDetail(task: task)
            } label: {
                playBtn
                Text(task.name)
            }
            .swipeActions(allowsFullSwipe: false) {
                checkBtn
                deleteBtn
            }
        }
    }
    
    
    var checkBtn: some View {
        Button {
            task.isCompleted.toggle()
        } label: {
            Label("complete", systemImage: task.isCompleted ? "checkmark")
        }
        .tint(task.isCompleted ? .purple.opacity(0.5) : .green.opacity(0.5))
    }
    
    var playBtn: some View {
        Image(systemName: task.isCompleted ? "checkmark.circle" : "play.circle")
            .foregroundColor(task.isCompleted ? Color.green : Color.purple)
            .imageScale(.large)
            .onTapGesture {
                
            }
    }
    
    var deleteBtn: some View {
        Button{} label: {
            Label("Delete", systemImage: "trash")
        }
        .tint(.red)
    }
}



//struct TaskRow_Previews: PreviewProvider {
//    static let modelData = ModelData()
//
//    static var previews: some View {
//        var $task = modelData.tasks[0]
//        TaskRow(task: $task)
//    }
//}
