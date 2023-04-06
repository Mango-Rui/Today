//
//  CountdownViewModel.swift
//  Today
//
//  Created by 李瑞 on 2023/1/4.
//

import Foundation
import SwiftUI
import BackgroundTasks
import UserNotifications


class CountdownViewModel: ObservableObject {
    @AppStorage("userDuration") var duration: Int = 0
    @AppStorage("showCountDown") var show: Bool = false
    @Published var progress: CGFloat = 0
    @Published var totalMinutes: Int16 = 0
    @Published var color = Color.white.opacity(0.7)

    var identifier: UIBackgroundTaskIdentifier!
    var startTime = Date.now
    var notificationHandler = NotificationHandler()
    var backgroundTaskID: UIBackgroundTaskIdentifier? = nil
    var coreDataStack: CoreDataStack?
    var task: TaskP?
    var timer: Timer?


    func startCountDownTimer(coreDataStack: CoreDataStack, task: TaskP) {
        self.coreDataStack = coreDataStack
        self.task = task

        identifier = UIApplication.shared.beginBackgroundTask()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if self.totalMinutes < self.duration {
                withAnimation {
                    self.totalMinutes += Int16(1)
                    self.progress = CGFloat(Double(self.totalMinutes)) / CGFloat(self.duration)
                }
            } else {
                if let coreDataStack = self.coreDataStack, let task = self.task {
                    timer.invalidate()
                    self.stopCountDownTimer(coreDataStack: coreDataStack, task: task)
                }
            }
        }

    }

    func stopCountDownTimer(coreDataStack: CoreDataStack, task: TaskP) {
        self.timer?.invalidate()
        UIApplication.shared.endBackgroundTask(identifier)
        coreDataStack.addFocus(startTime: startTime, duration: totalMinutes, task: task)
        notificationHandler.sendNotifications(title: "Good job!", body: "Focus work finished")
        let project = task.project
        project.moveTask(from: task.index, to: 0)
        show = false
    }

}
