//
//  FlagFilter.swift
//  Today
//
//  Created by 李瑞 on 2023/1/4.
//

import SwiftUI
import Foundation

enum FlagColorEnum: Int16, CaseIterable {
    case gray = 0
    case yellow = 1
    case orange = 2
    case red = 3
    case blue = 4

    var color: Color {
        switch self {
            case .gray:
                return .gray
            case .yellow:
                return .yellow
            case .orange:
                return .orange
            case .red:
                return .red
            case .blue:
                return .blue
        }
    }
}

struct FlagFilter: View {
    @Binding var currentFlag: Int16
    var action: (() -> Void)? = nil

    var body: some View {
        ForEach(FlagColorEnum.allCases, id: \.self) { flag in
            Circle()
                .fill(flag.rawValue == self.currentFlag ? flag.color.opacity(0.5) : flag.color)
                .frame(width: 25, height: 25)
                .overlay(
                    Circle()
                        .stroke(lineWidth: 2)
                        .foregroundColor(flag.rawValue == self.currentFlag ? .purple : .clear)
                )
                .onTapGesture {
                    withAnimation {
                        self.currentFlag = flag.rawValue
                        if let action = action {
                            action()
                        }
                    }
                }
        }
    }

}


