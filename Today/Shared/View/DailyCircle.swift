//
//  FinishRateCircle.swift
//  Today
//
//  Created by 李瑞 on 7/3/2023.
//
import SwiftUI


struct DailyCircle: View {
    @AppStorage("dailyGoal") var goal = 1
    var goal1 = 400

    var total: Int16

    var finishRate: CGFloat {
        if goal > 0 {
            return CGFloat(Double(total) / Double(goal))
        } else {
            return CGFloat(0)
        }
    }

    var finishColor: Color {
        return finishRate >= 1 ? .green : .purple
    }

    var weekBoundary = Calendar.weekBoundary(for: Date())

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text("Today:")

                Text("\(total)")
                    .font(.title3)
                    .foregroundColor(finishColor)
                    .bold()
            }
            .padding(.bottom)

            ZStack {
                Circle()
                    .trim(from: 0, to: 1)
                    .stroke(Color.gray.opacity(0.15), style: StrokeStyle(lineWidth: 8, lineCap: .round))
                    .frame(width: 120, height: 120)
                Circle()
                    .trim(from: 0, to: finishRate)
                    .stroke(.green, style: StrokeStyle(lineWidth: 8, lineCap: .round))
                    .rotationEffect(.init(degrees: -90))
                    .frame(width: 120, height: 120)
                Text(String(format: "%.0f%%", finishRate * 100))
                    .foregroundColor(finishColor)
                    .font(.title)
                    .bold()
            }
            
            Spacer()
        }
    }
}

