//
//  UserView.swift
//  Today
//
//  Created by 李瑞 on 2022/11/15.
//

import SwiftUI

struct UserView: View {
    @AppStorage("userDuration") var duration: Int = 25
    @AppStorage("dailyGoal") var dailyTarget: Int = 100


    var body: some View {
        NavigationView {
            List {
                // focus time
                Section {
                    Stepper("Focus Time: \(duration) mins", value: $duration, in: 5...60, step: 5)
                        .imageScale(.small)
                } header: {
                    Text("Count Down")
                }

                // daily target
                Section {
                    Stepper("Focus Time: \(dailyTarget) mins", value: $dailyTarget, in: 10...800, step: 10)
                        .imageScale(.small)
                } header: {
                    Text("Dailty Target")
                }


            }
            .listRowSeparator(.hidden)
            .listStyle(.insetGrouped)
            .navigationTitle("Settings")
            .accentColor(.purple)
        }

    }
}

//struct UserView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserView()
//    }
//}
