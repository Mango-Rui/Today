//
//  ContentView.swift
//  Today
//
//  Created by 李瑞 on 2022/11/14.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.purple)
            Text("Plan, start, focus, and be free!")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color.purple)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
