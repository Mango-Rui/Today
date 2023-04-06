//
//  TodayApp.swift
//  Today
//
//  Created by 李瑞 on 2022/11/14.
//

import SwiftUI

@main
struct TodayApp: App {
    @Environment(\.scenePhase) var scenePhase
    @StateObject var coreDataStack = CoreDataStack()

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
                        Label("Todos", systemImage: "list.bullet")
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
            .environmentObject(coreDataStack)
            .environment(\.managedObjectContext, coreDataStack.viewContext)
            .onChange(of: scenePhase) { _ in
                coreDataStack.viewContext.saveChanges()
            }
            .onAppear {
//                coreDataStack.addTasks()
            }
           
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
