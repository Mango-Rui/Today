//
//  TaskDetail.swift
//  Today
//
//  Created by 李瑞 on 2022/11/16.
//

import SwiftUI

struct TaskDetail: View {
    var task: Task
    
    var body: some View {
        Text(task.name)
    }
}

struct TaskDetail_Previews: PreviewProvider {
    static var modelData = ModelData()
    
    static var previews: some View {
        TaskDetail(task: modelData.tasks[0])
    }
}
