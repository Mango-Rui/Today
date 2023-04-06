//
//  PlainNavigationLinkStyle.swift
//  Today
//
//  Created by 李瑞 on 21/2/2023.
//

import SwiftUI

struct PlainNavigationLinkStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
            configuration.label
                .foregroundColor(configuration.isPressed ? Color.accentColor.opacity(0.5) : .accentColor)
                .accentColor(Color.accentColor)
                .background(configuration.isPressed ? Color.gray.opacity(0.2) : Color.clear)
        }
}


