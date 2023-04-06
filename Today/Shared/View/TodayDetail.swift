//
//  TodayDetail.swift
//  Today
//
//  Created by 李瑞 on 2022/11/17.
//

import SwiftUI

struct TodayDetail: View {
    @Namespace var namespace
    @State var show: Bool = false
    
    var body: some View {
        ZStack {
            if show {
                Text("Hello, World!")
                    .font(.largeTitle.weight(.bold))
                    .matchedGeometryEffect(id: "title", in: namespace)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(
                        Image("Background 5")
                            .matchedGeometryEffect(id: "background", in: namespace)
                    )
            } else {
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                    .font(.largeTitle.weight(.bold))
                    .matchedGeometryEffect(id: "title", in: namespace)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .background()
                    .matchedGeometryEffect(id: "background", in: namespace)
            }
        }
        .onTapGesture {
            withAnimation {
                show.toggle()
            }
        }
        
    }
}

//struct TodayDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        TodayDetail()
//    }
//}
