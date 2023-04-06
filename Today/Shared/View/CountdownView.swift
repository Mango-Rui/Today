//
//  CountDownView.swift
//  Today
//
//  Created by 李瑞 on 2022/11/18.
//

import SwiftUI
import Foundation

struct CountDownView: View {
    @StateObject var vm: CountdownViewModel = .init()
    @EnvironmentObject var coreDataStack: CoreDataStack
    @AppStorage("userDuration") var duration: Int = 0

    var task: TaskP

    var body: some View {
        ZStack {
            circle
            btn
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background { Color(.black).ignoresSafeArea() }
        .statusBarHidden(true)
        .toolbar(.hidden, for: .tabBar)
        .onAppear {
            vm.startCountDownTimer(coreDataStack: coreDataStack, task: task)
        }
    }

    var circle: some View {
        ZStack {
            Circle()
                .trim(from: 0, to: 1)
                .stroke(Color.white.opacity(0.15), style: StrokeStyle(lineWidth: 8, lineCap: .round))
                .frame(width: 240, height: 240)
            Circle()
                .trim(from: 0, to: vm.progress)
                .stroke(.white, style: StrokeStyle(lineWidth: 8, lineCap: .round))
                .frame(width: 240, height: 240)
                .rotationEffect(.init(degrees: -90))
            //            Circle()
            //                .trim(from: 0, to: progress)
            //                .stroke(color, style: StrokeStyle(lineWidth: 24, lineCap: .round))
            //                .frame(width: 240, height: 240)
            //                .rotationEffect(.init(degrees: -90))
            //                .blur(radius: 12)
            VStack {
                Text("\(duration - Int(vm.totalMinutes))")
                    .foregroundColor(.white)
                    .font(.system(size: 80).bold())
            }
        }
        .ignoresSafeArea()
    }

    var btn: some View {
        VStack {
            Text(task.name)
                .foregroundColor(.white)
                .font(.title.bold())
                .padding()
                .lineLimit(1)

            Text(Date.now, format: .dateTime.hour().minute())
                .foregroundColor(.white)

            Spacer()

            Button {
                vm.stopCountDownTimer(coreDataStack: coreDataStack, task: task)
            } label: {
                Image(systemName: "stop.circle")
                    .foregroundColor(vm.color)
                    .font(.largeTitle)
            }
        }
        .padding()
    }
}



//struct ClockView_Previews: PreviewProvider {
//    static let clockViewModel = ClockViewModel()
//    static var previews: some View {
//        ClockView(clock: clockViewModel)
//            .environmentObject(ModelData())
//    }
//}
