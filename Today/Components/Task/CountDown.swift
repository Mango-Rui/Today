//
//  CountDownView.swift
//  Today
//
//  Created by 李瑞 on 2022/11/18.
//

import SwiftUI

struct CountDown: View {
    
    var body: some View {
        VStack {
            Spacer()
            HStack() {
                Spacer()
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.white)
                Spacer()
            }
            Spacer()
        }
        .background(Color(.black))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .statusBarHidden(true)
    }
}

struct CountDown_Previews: PreviewProvider {
    static var previews: some View {
        CountDown()
    }
}
