//
//  TaskView.swift
//  Today
//
//  Created by 李瑞 on 2022/11/15.
//

import SwiftUI

struct TaskView: View {
    @EnvironmentObject var coreDataStack: CoreDataStack
    @AppStorage("showCountDown") var showCountDown = false
    @ObservedObject var vm = TaskViewModel()

    @FetchRequest(sortDescriptors: [])
    private var projects: FetchedResults<Project>

    @State var selectedFlag: Int16 = -1
    @State var newProjectName: String = ""
    @State var isShowNewProjectModal: Bool = false

    var filteredProjectList: [Project] {
        let projectList = Array(self.projects)
        if selectedFlag == -1 {
            return projectList
        } else {
            return projectList.filter { $0.flag == selectedFlag }
        }
    }
    
    var body: some View {
        ZStack {
            NavigationView {
                List {
                    filterRow
                    projectGroup
                }
                .accentColor(.purple)
                .navigationTitle("Todos")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(leading:EditButton(), trailing: newProjectBtn)
                .listStyle(.grouped)
            }


            if showCountDown {
                if let task = vm.currentTask {
                    CountDownView(task: task)
                }
            }
        }
        .environmentObject(vm)
    }

    private var newProjectBtn: some View {
        NavigationLink(destination: ProjectDetail(isNew: true)) {
            Image(systemName: "plus")
        }
    }

    private var filterRow: some View {
        HStack {
            FlagFilter(currentFlag: $selectedFlag)

            Spacer()

            Button {
                withAnimation { selectedFlag = -1 }
            } label: {
                Text("clear")
            }
        }
    }


    private var projectGroup: some View {
        ForEach(filteredProjectList, id: \.id) { project in
            ProjectGroup(project: project)
        }
    }
}

