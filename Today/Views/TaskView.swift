//
//  TaskView.swift
//  Today
//
//  Created by 李瑞 on 2022/11/15.
//

import SwiftUI

struct TaskView: View {
    @EnvironmentObject var modelData: ModelData
    @StateObject var clock = ClockViewModel()
    @AppStorage("showClock") var showClock = false
    
    
    var body: some View {
        ZStack {
            NavigationStack {
                List {
                    ForEach(modelData.projects) { project in
                        ProjectSection(project: project)
                    }
                    NewProjectSection()
                }
                .listStyle(.insetGrouped)
                .navigationTitle("Tasks")
            }
            if showClock {
                ClockView()
                    .environmentObject(clock)
            }
        }
        
    }
    
    private struct ProjectSection: View {
        @EnvironmentObject var modelData: ModelData
        var project: Project
        var body: some View {
            Section {
                ForEach(modelData.tasks(in: project)) { task in
                    TaskRow(task: task)
                }
                TaskRowNew(project: project)
            } header: {
                SectionHeader(project: project)
            }
            .textCase(.none)
        }
        
    }
    
    private struct SectionHeader: View {
        var project: Project
        var body: some View {
            HStack() {
                Text(project.name)
                    .foregroundColor(.primary)
                    .font(.title3.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                Button {
                    
                } label: {
                    Image(systemName: "chevron.right")
                }
            }
            .padding(.leading, -20)
        }
    }
    
    private struct NewProjectSection: View {
        @EnvironmentObject var modelData: ModelData
        @State var newProjectName: String = ""
        
        var body: some View {
            Section {
                HStack {
                    Image(systemName: "circle")
                        .foregroundColor(Color(.systemGray3))
                        .imageScale(.large)
                    TextField("New Project", text: $newProjectName)
                        .onSubmit {
                            let newProject: Project = Project.createByName(name: newProjectName)
                            modelData.projects.append(newProject)
                            newProjectName = ""
                        }
                        .textInputAutocapitalization(.never)
                }
            }
        }
        
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView()
            .environmentObject(ModelData())
    }
}
