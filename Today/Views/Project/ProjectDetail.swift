//
//  ProjectDetail.swift
//  Today
//
//  Created by 李瑞 on 2022/11/16.
//

import SwiftUI

struct ProjectDetail: View {
    var project: Project
    
    var body: some View {
        Section {
            Text(project.name)
        }
    }
}

struct ProjectDetail_Previews: PreviewProvider {
    static let modelData = ModelData()
    
    static var previews: some View {
        ProjectDetail(project: modelData.projects[1])
    }
}
