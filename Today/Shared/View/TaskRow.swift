//
//  TaskRow.swift
//  Today
//
//  Created by 李瑞 on 2022/11/14.
//

import SwiftUI


struct TaskRow: View {
    @EnvironmentObject var vm: TaskViewModel
    @EnvironmentObject var coreDataStack: CoreDataStack
    @Namespace var namespace
    @State private var isCompleted = false
    @State private var isModalOpen = false

    @AppStorage("showCountDown") var showCountDown = false

    var task: TaskP
    
    var body: some View {
        ZStack {
            HStack {
                playBtn
                    .padding(.top, 8)

                taskName

                Spacer()

                checkBox

            }
            .contentShape(Rectangle())
            .onTapGesture {
                isModalOpen.toggle()
            }
            .sheet(isPresented: $isModalOpen) {
                TaskDetail(task: task, isModalOpen: $isModalOpen).environmentObject(task)
            }
        }
        .onAppear {
            isCompleted = task.isCompleted
        }
    }

    var playBtn: some View {
        VStack {
            Image(systemName: task.isCompleted ? "checkmark.circle" : "play.circle")
                .foregroundColor(task.isCompleted ? Color.green : Color.purple)
                .imageScale(.large)
            Spacer()
        }
        .onTapGesture {
            if !task.isCompleted {
                print(task)
                showCountDown.toggle()
                vm.currentTask = self.task
            }
        }
    }

    var taskName: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(task.name)
            Text("\(task.focusTime) min")
                .font(.footnote)
                .foregroundColor(.secondary)
        }
        .multilineTextAlignment(.leading)
    }

    var checkBox: some View {
        Button {
            task.isCompleted.toggle()
            isCompleted = task.isCompleted
            if task.isCompleted {
                task.project.moveTask(from: task.index, to: task.project.tasks.count - 1)
            } else {
                task.project.moveTask(from: task.index, to: 0)
            }

        } label: {
            Image(systemName: task.isCompleted ? "checkmark.square" : "square")
                .font(.system(size: 20))
        }
        .tint(task.isCompleted ? .green : .purple)
        .buttonStyle(BorderlessButtonStyle())
    }

}

