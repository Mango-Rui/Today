//
//  ClockModel.swift
//  Today
//
//  Created by 李瑞 on 2022/11/21.
//

import Foundation
import SwiftUI

class ClockViewModel: ObservableObject {
    @AppStorage("defaultFocusTime") var time: Int = 5
    @Published var progress: CGFloat = 0
    @Published var totalMinutes = 0
    @Published var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    @Published var color = Color.white.opacity(0.7)
    var notificationHandler = NotificationHandler()

    func addNotification() {
        notificationHandler.sendNotifications(title: "Good job!", body: "Focus work finished")
    }
}
