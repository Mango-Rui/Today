//
//  CountdownTimer.swift
//  Today
//
//  Created by 李瑞 on 2023/1/3.
//

import Foundation
import UIKit

class BackgroundTimer {
    private var duration: Int
    private var backgroundTaskID: UIBackgroundTaskIdentifier? = nil
    var timer: Timer = Timer()

    init(duration: Int) {
        self.duration = duration
        self.timer = Timer.scheduledTimer(timeInterval: Double(duration), target: self, selector: #selector(tick), userInfo: nil, repeats: false)
        self.backgroundTaskID = UIApplication.shared.beginBackgroundTask(expirationHandler: timerExpirationHandler)
    }

    @objc func tick() {
        duration -= 1
        if duration <= 0 {
            terminateTimer()
            // Push the notification here
        }
    }

    func timerExpirationHandler() {
        terminateTimer()
    }

    private func terminateTimer() {
        timer.invalidate()

        if let backgroundTaskID = backgroundTaskID {
            UIApplication.shared.endBackgroundTask(backgroundTaskID)
        }
    }
}


