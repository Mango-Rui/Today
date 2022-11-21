//
//  ClockView.swift
//  Today
//
//  Created by 李瑞 on 2022/11/18.
//

import SwiftUI
import UserNotifications
import Foundation

struct ClockView: View {
    @AppStorage("showClock") var showClock: Bool = false
    @AppStorage("currentTask") var currentTaskId: String = "1"
    @EnvironmentObject var modelData: ModelData
    @StateObject var clock = ClockViewModel()
    let notificationHandler = NotificationHandler.shared

    var taskIndex: Int? {
        modelData.tasks.firstIndex { $0.id == currentTaskId }
    }
    var task: Task? {
        if let index = taskIndex {
            return modelData.tasks[index]
        } else {
            return nil
        }
    }

    var body: some View {
        ZStack {
            circle
            btn
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background { Color(.black).ignoresSafeArea() }
        .statusBarHidden(true)
        .toolbar(.hidden, for: .tabBar)
        .onReceive(clock.timer) { _ in handleTimer() }
        .onAppear { notificationHandler.askPermission() }
    }

    var circle: some View {
        ZStack {
            Circle()
                .trim(from: 0, to: 1)
                .stroke(Color.white.opacity(0.15), style: StrokeStyle(lineWidth: 8, lineCap: .round))
                .frame(width: 240, height: 240)
            Circle()
                .trim(from: 0, to: clock.progress)
                .stroke(.white, style: StrokeStyle(lineWidth: 8, lineCap: .round))
                .frame(width: 240, height: 240)
                .rotationEffect(.init(degrees: -90))
            Circle()
                .trim(from: 0, to: clock.progress)
                .stroke(clock.color, style: StrokeStyle(lineWidth: 24, lineCap: .round))
                .frame(width: 240, height: 240)
                .rotationEffect(.init(degrees: -90))
                .blur(radius: 24)
            VStack {
                Text("\(clock.time - clock.totalMinutes)")
                    .foregroundColor(.white)
                    .font(.system(size: 80).bold())
            }
        }
        .ignoresSafeArea()
    }

    var btn: some View {
        VStack {
            if let task = task {
                Text(task.name)
                    .foregroundColor(.white)
                    .font(.title.bold())
                    .padding()
                    .lineLimit(1)
            }
            Spacer()
            Button {
                handleClockStop()
            } label: {
                Image(systemName: "stop.circle")
                    .foregroundColor(clock.color)
                    .font(.largeTitle)
            }
        }
        .padding()
    }

    func handleClockStop() {
        if let index = taskIndex {
            modelData.tasks[index].addFocusTime(by: clock.totalMinutes)
        }
        showClock = false
    }

    func handleTimer() {
        if clock.totalMinutes < clock.time {
            withAnimation {
                clock.totalMinutes += 1
                clock.progress = CGFloat(clock.totalMinutes) / CGFloat(clock.time)
            }
        } else {
            handleClockStop()
            clock.addNotification()
        }
    }
}



struct ClockView_Previews: PreviewProvider {
    static let clockViewModel = ClockViewModel()
    static var previews: some View {
        ClockView(clock: clockViewModel)
            .environmentObject(ModelData())
    }
}
