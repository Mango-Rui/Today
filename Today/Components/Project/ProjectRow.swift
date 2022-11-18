//
//  ProjectRow.swift
//  Today
//
//  Created by 李瑞 on 2022/11/16.
//

import SwiftUI

struct ProjectRow: View {
    @EnvironmentObject var modelData: ModelData
    var project: Project
    
    
    var body: some View {
        NavigationLink {
            ProjectDetail(project: project)
        } label: {
            Text(project.name)
        }
        .swipeActions {
            Button {
                
            } label: {
                Label("Delete", systemImage: "trash")
            }
            .tint(.red)
        }
    }
}

struct ProjectRow_Previews: PreviewProvider {
    static let modelData = ModelData()
    
    static var previews: some View {
        ProjectRow(project: modelData.projects[1])
    }
}
