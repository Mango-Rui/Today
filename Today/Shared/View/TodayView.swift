//
//  TodayView.swift
//  Today
//
//  Created by 李瑞 on 2022/11/14.
//

import SwiftUI

struct TodayView: View {
    @ObservedObject var vm = TaskViewModel()
    @AppStorage("showCountDown") var showCountDown = false
    @State var currentTab: String = "Day"
    @Namespace var animation

    @FetchRequest(sortDescriptors: [], predicate: Focus.weekPredicate())
    private var weekFocusList: FetchedResults<Focus>

    @FetchRequest(sortDescriptors: [])
    private var projects: FetchedResults<Project>

    var startOfDay = Calendar.dayBoundary(for: Date()).startOfDay
    var endOfDay = Calendar.dayBoundary(for: Date()).endOfDay

    var dayFocusList: [Focus] {
        return weekFocusList.filter { $0.startTime >= startOfDay && $0.startTime <= endOfDay }
    }

    var todayFocus: Int16 {
        var total: Int16 = 0
        dayFocusList.forEach { focus in
            total += focus.duration
        }
        return total
    }

    var body: some View {
        ZStack {
            NavigationView {
                List {
                    chartSection

                    taskSection
                    HStack {
                        Text("Tasks")
                    }
                }
                .navigationTitle("Today")
                .accentColor(.purple)
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

    private var chartSection: some View {
        Section {
            HStack() {
                DailyCircle(total: todayFocus)
                Spacer()
                WeeklyChart(weekFocusList: weekFocusList)
            }
            .padding(.top)
            .padding(.leading)
        }
    }

    private var taskSection: some View {
        ForEach(projects, id: \.id) { project in
            ProjectGroup(project: project)
        }
    }
}



//struct TodayView_Previews: PreviewProvider {
//    static var previews: some View {
//        TodayView()
//    }
//}


