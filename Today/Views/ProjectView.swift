//
//  ProjectView.swift
//  Today
//
//  Created by 李瑞 on 2022/11/16.
//

import SwiftUI

struct ProjectView: View {
    @EnvironmentObject var modelData: ModelData

    var body: some View {
        NavigationStack {
            List {
                ForEach(modelData.projects) { project in
                    ProjectRow(project: project)
                }
            }
            .navigationTitle("Projects")
        }
    }
}

struct ProjectView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectView()
            .environmentObject(ModelData())
    }
}
