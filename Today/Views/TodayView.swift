//
//  TodayView.swift
//  Today
//
//  Created by 李瑞 on 2022/11/14.
//

import SwiftUI

struct TodayView: View {
    var body: some View {
        tabView
        
        
    }
    
    var tabView: some View {
        TabView {
            ForEach(0..<5) { item in
                GeometryReader { proxy in
                    let minX = proxy.frame(in: .global).minX
                    StatisticsCard(cardNumber: item)
                        .rotation3DEffect(.degrees( -(minX - 16) / 10), axis: (x: 0, y: 1, z: 0))
                        .shadow(color: Color(.purple).opacity(0.3), radius: 10, x: 0, y: 10)
                        .blur(radius: abs(minX - 16) / 40)
                }
            }
            .padding()
            
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(height: 430)
    }
}

struct TodayView_Previews: PreviewProvider {
    static var previews: some View {
        TodayView()
    }
}
