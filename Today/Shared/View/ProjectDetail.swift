//
//  ProjectDetail.swift
//  Today
//
//  Created by 李瑞 on 2022/11/16.
//

import SwiftUI

struct ProjectDetail: View {
    @Environment(\.presentationMode) var presentationMode
    @AppStorage("showCountDown") var showCountDown = false
    @EnvironmentObject var coreDataStack: CoreDataStack

    @State var project: Project?
    @State var isNew: Bool
    @State private var projectProperties: ProjectProperties = .empty
    @State var isEditingName = false
    @State var isRefresh = false

    private var projectTitle: String {
        if let project = project {
            return project.name
        } else {
            return "New Project"
        }
    }

    var body: some View {
        List {
            formSection
            if project != nil {
                taskSection
            }

        }
        .navigationBarTitle(projectTitle)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            if let project = project {
                projectProperties = project.properties
            }
            if isNew { isEditingName = true }
        }
        .onChange(of: showCountDown) { newValue in
            if !newValue {
                isRefresh.toggle()
            }
        }
    }

    func addProject() {
        project = coreDataStack.addProject(properties: projectProperties)
        isNew = false
    }

    func updateProject() async {
        guard project != nil else { return }
        project = await coreDataStack.updateProject(project: project!, properties: projectProperties)
    }

    func updateProjectFlag() {
        if let project = project {
            coreDataStack.updateProjectFlag(flag: projectProperties.flag, project: project)
        }
    }

    // MARK: Project Form
    @State private var showDeleteConfirm = false
    private var formSection: some View {
        Section {
            // Project Name
            HStack {
                Text("Name")
                if isEditingName {
                    TextField("New Project Name", text: $projectProperties.name)
                        .textFieldStyle(.roundedBorder)
                    Button("done") {
                        if isNew {
                            addProject()
                        } else {
                            Task {
                                await updateProject()
                            }
                        }
                        isEditingName = false
                    }
                } else {
                    Text(projectProperties.name)
                    Spacer()
                    Button {
                        isEditingName = true
                    } label: {
                        Image(systemName: "pencil")
                    }
                }

            }

            // Project Flag
            if !isNew {
                HStack {
                    Text("Flag")
                        .padding(.trailing)
                    FlagFilter(currentFlag: $projectProperties.flag, action: updateProjectFlag)
                    Spacer()
                    Button("clear") {
                        projectProperties.flag = -1
                        updateProjectFlag()
                    }
                }
            }


            // Total Focus
            if let project = project {
                HStack {
                    Text("Total Focus")
                    Spacer()

                    Text(String(project.focusTime))
                        .foregroundColor(.purple)
                    Text("min")
                }
            }


            // Delete Button
            if project != nil {
                HStack {
                    Button {
                        self.showDeleteConfirm = true
                    } label: {
                        Text("Delete")
                            .foregroundColor(.red)
                    }
                    .alert(isPresented: $showDeleteConfirm) {
                        Alert(
                            title: Text("Delete Project"),
                            message: Text("Are you sure you want to delete this project?"),
                            primaryButton: .destructive(Text("Delete")) {
                                deleteProject()
                            },
                            secondaryButton: .cancel()
                        )
                    }
                }
            }


        } header: {
            Text("Project Info")
        }
        .textInputAutocapitalization(.never)
        .textCase(.none)
        .listRowSeparator(.hidden)
    }

    private func deleteProject() {
        if let project = project {
            coreDataStack.deleteProject(project: project)
        }
        presentationMode.wrappedValue.dismiss()
        self.showDeleteConfirm = false
    }

    func changeProjectFlag() {
        coreDataStack.updateProjectFlag(flag: projectProperties.flag, project: self.project!)
    }

    // MARK: Task List
    @State var showSheet = false
    @State var taskCount = 1
    @State var newTaskName = ""
    @State var prefix = ""
    @State var suffix = ""
    private var batchTaskName: String {
        "\(prefix) 1 \(suffix) ... \(prefix) \(String(taskCount)) \(suffix)"
    }

    private var taskSection: some View {
        Section {
            // batch add task sheet
            if showSheet { taskSheet }

            // task list
            if let project = project {
                ForEach(project.taskList, id: \.id) { task in
                    TaskRow(task: task)
                }
            }

        } header: {
            HStack {
                Text("Project Tasks")
                Spacer()
                Button {
                    withAnimation {
                        showSheet = true
                    }
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .textCase(.none)
    }

    private var taskSheet: some View {
        VStack {
            // task count
            HStack {
                Stepper("Task Count: \(taskCount)", value: $taskCount, in: 1...99)
                    .imageScale(.small)
            }

            // single task name
            if taskCount == 1 {
                HStack {
                    Text("Task Name")
                    Spacer()
                    TextField("Task Name", text: $newTaskName)
                        .textFieldStyle(.roundedBorder)
                }
            }

            // batch task name
            if taskCount > 1 {
                HStack {
                    Text("Prefix")
                    Spacer()
                    TextField("Prefix of Task Name", text: $prefix)
                        .textFieldStyle(.roundedBorder)
                }
                HStack {
                    Text("Suffix")
                    Spacer()
                    TextField("Suffix of Task Name", text: $suffix)
                        .textFieldStyle(.roundedBorder)
                }
                if !prefix.isEmpty || !suffix.isEmpty {
                    HStack() {
                        Text(batchTaskName)
                            .font(.footnote)
                            .foregroundColor(.gray).opacity(0.8)
                        Spacer()
                    }
                }
            }

            // save btn
            Button {
                resignFirstResponder()
                batchSaveTask()
            } label: {
                Text("Save")
                    .padding(3)
                    .font(.body)
            }
            .frame(maxWidth: .infinity)
            .background(Color.purple)
            .foregroundColor(.white)
            .cornerRadius(5)
            .padding(.top, 20)
        }
    }

    private func batchSaveTask() {
        if taskCount == 1 {
            coreDataStack.addTask(name: self.newTaskName, project: project!)
        }
        else if taskCount > 1 {
            var names = [String]()
            for n in 1...taskCount {
                let name = "\(prefix) \(String(n)) \(suffix)"
                names.append(name)
            }
            coreDataStack.addTasksToProject(names: names, project: project!)
        }
        showSheet = false
    }

    func resignFirstResponder() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}



//struct ProjectDetail_Previews: PreviewProvider {
//    static let modelData = ModelData()
//
//    static var previews: some View {
//        ProjectDetail(modelData: modelData, project: modelData.projects[0])
//    }
//}
