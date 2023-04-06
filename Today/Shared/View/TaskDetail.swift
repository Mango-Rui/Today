//
//  TaskDetail.swift
//  Today
//
//  Created by 李瑞 on 2022/11/16.
//

import SwiftUI

struct TaskDetail: View {
    @EnvironmentObject var coreDataStack: CoreDataStack
    @EnvironmentObject var vm: TaskViewModel
    @EnvironmentObject var task: TaskP

    @State var newTaskName: String = ""
    @State var newProject: Project = Project()

    @Binding var isModalOpen: Bool


    @FetchRequest(sortDescriptors: [])
    private var projects: FetchedResults<Project>

    var fetchRequest: FetchRequest<Focus>
    var focusList: FetchedResults<Focus> {
        fetchRequest.wrappedValue
    }

    init(task: TaskP, isModalOpen: Binding<Bool>) {
        fetchRequest = FetchRequest(fetchRequest: Focus.getFocusList(of: task))
        _isModalOpen = isModalOpen
    }

    var body: some View {
        NavigationView {
            List {
                taskForm
                focusSection
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(task.name)
            .navigationBarItems(leading: cancelBtn, trailing: saveBtn)
            .accentColor(.purple)
        }
        .onAppear {
            newTaskName = task.name
            newProject = task.project
        }
    }

    private var cancelBtn: some View {
        Button("Cancel") {
            isModalOpen.toggle()
        }
    }

    private var saveBtn: some View {
        Button("Save") {
            saveTaskInfo()
            isModalOpen.toggle()
        }
    }

    private var taskForm: some View {
        Section {
            // Task Name
            HStack {
                Text("Task Name")
                Spacer()
                TextField("Task Name", text: $newTaskName)
                    .textFieldStyle(.roundedBorder)
            }
            .textInputAutocapitalization(.never)

            // Project
            Picker("Project", selection: $newProject) {
                ForEach(projects, id: \.id) { project in
                    Text(String(project.name)).tag(project)
                }
            }
            .onChange(of: newProject) { newValue in
                task.project = newValue
            }

            // Focus Time
            HStack {
                Text("Total Focus")
                Spacer()
                Text(String(task.focusTime))
                    .foregroundColor(.purple)
                Text("min")
            }
        } header: {
            Text("Task Info")
        }
        .textCase(.none)
        .listRowSeparator(.hidden)
    }

    func saveTaskInfo() {
        task.name = newTaskName
    }

    var focusSection: some View {
        Section {
            ForEach(Array(focusList), id: \.self.id) { focus in
                HStack {
                    Image(systemName: focus.imageName)
                        .foregroundColor(focus.isDay ? .yellow : .purple)
                    Text(focus.startTime.formatted(date: .numeric, time: .shortened))
                    Spacer()
                    Text(String(focus.duration))
                        .foregroundColor(.purple)
                    Text("min")
                        .font(.footnote)
                }
                .swipeActions(allowsFullSwipe: false) {
                    Button{
                        coreDataStack.deleteFocus(focus: focus)
                    } label: {
                        Label("delete", systemImage: "trash")
                    }
                    .tint(.red)
                }
            }
        } header: {
            Text("Focus Records")
        }
        .textCase(.none)
    }
}

//struct TaskDetail_Previews: PreviewProvider {
//    static var modelData = ModelData()
//
//    static var previews: some View {
//        TaskDetail(task: modelData.tasks[0])
//            .environmentObject(ModelData())
//    }
//}
