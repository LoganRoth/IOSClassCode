//
//  ContentView.swift
//  FirstSwiftUI
//
//  Created by Logan Roth on 2021-01-09.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello, world!")
                .font(.headline)
                .multilineTextAlignment(.leading)
                .padding()
            Text("Sup")
                .font(.subheadline)
                .foregroundColor(Color.red)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
