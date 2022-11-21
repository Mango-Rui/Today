//
//  NotificationHandler.swift
//  Today
//
//  Created by 李瑞 on 2022/11/20.
//

import Foundation
import UserNotifications

class NotificationHandler {
    static let shared = NotificationHandler()
    func askPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .alert, .sound]) { success, error in
            if success {
                print("permission granted")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }

    func sendNotifications(title: String, body: String) {
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)

        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request)
    }
}
