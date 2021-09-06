//
//  ContentView.swift
//  NetflixClone
//
//  Created by Logan Roth on 2021-01-19.
//

import SwiftUI

struct ContentView: View {
    
    init() {
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().barTintColor = UIColor.black
    }
    
    var body: some View {
        
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
                .tag(0)
            Text("Stuff")
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Seach")
                }
                .tag(1)
            Text("Stuff")
                .tabItem {
                    Image(systemName: "play.rectangle")
                    Text("Coming Soon")
                }
                .tag(2)
            Text("Stuff")
                .tabItem {
                    Image(systemName: "arrow.down.to.line.alt")
                    Text("Downloads")
                }
                .tag(3)
            Text("Stuff")
                .tabItem {
                    Image(systemName: "equal")
                    Text("More")
                }
                .tag(4)
        }.accentColor(.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
