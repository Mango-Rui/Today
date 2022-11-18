//
//  TodayApp.swift
//  Today
//
//  Created by 李瑞 on 2022/11/14.
//

import SwiftUI

@main
struct TodayApp: App {
    @StateObject var modelData = ModelData()
    var body: some Scene {
        #if os(iOS)
        WindowGroup {
            TabView {
                TodayView()
                    .tabItem {
                        Label("Today", systemImage: "sunrise.circle")
                    }
                TaskView()
                    .tabItem{
                        Label("Task", systemImage: "list.bullet")
                    }
                CalendarView()
                    .tabItem {
                        Label("Calendar", systemImage: "calendar")
                    }
                UserView()
                    .tabItem {
                        Label("Settings", systemImage: "person")
                    }
            }
            .environmentObject(modelData)
        }
        #elseif os(macOS)
        WindowGroup {
            TodayView()
        }
        Settings {
            UserView()
        }
        #endif
    }
}
