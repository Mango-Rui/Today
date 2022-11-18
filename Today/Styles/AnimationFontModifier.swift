//
//  AnimationFontModifier.swift
//  Today
//
//  Created by 李瑞 on 2022/11/17.
//

import SwiftUI

struct AnimationFontModifier: AnimatableModifier {
    var size: Double
    var weight: Font.Weight
    var design: Font.Design
    
    var animatableData: Double {
        get { size }
        set { size = newValue }
    }
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: size))
    }
}

extension View {
    func animatableFont(size: Double, weight: Font.Weight = .regular, design: Font.Design = .default) -> some View{
        self.modifier(AnimationFontModifier(size: size, weight: weight, design: design))
    }
}

