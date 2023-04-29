//
//  ContentView.swift
//  PomodoroTimer
//
//  Created by Bekainar on 29.04.2023.
//

import SwiftUI

enum Tab {
    case main
    case settings
    case history
}

struct ContentView: View {
    
    @State private var selectedTab : Int = 1
    
    var body: some View {
        TabView(selection: $selectedTab) {
            mainScreen()
                .tabItem {
                    Label("Main", systemImage: "house")
                } .tag(Tab.main)
            settingsScreen()
                .tabItem {
                    Label("Settings", systemImage: "slider.horizontal.3")
                } .tag(Tab.settings)
             historyScreen()
                .tabItem{
                    Label("History", systemImage: "doc")
                } .tag(Tab.history)
        }
        .accentColor(.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
