//
//  StatisticsCard.swift
//  Today
//
//  Created by 李瑞 on 2022/11/17.
//

import SwiftUI

struct StatisticsCard: View {
    var cardNumber: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Spacer()
            Image(systemName: "swift")
                .resizable()
                .foregroundColor(Color.purple)
                .frame(width: 26.0, height: 26.0)
            Text("Hello\(self.cardNumber), card,card,card,card,card,card")
                .font(.largeTitle)
                .fontWeight(.bold)
            Text("i will do it well")
                .font(.footnote)
                
        }
        .padding()
        .frame(height: 350)
        .background(.ultraThinMaterial)
        .cornerRadius(30)
    }
}

struct StatisticsCard_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsCard(cardNumber: 0)
    }
}
