//
//  historyScreen.swift
//  PomodoroTimer
//
//  Created by Bekainar on 29.04.2023.
//

import SwiftUI

struct historyScreen: View {
    var body: some View {
        VStack{
            HStack{
                Text("History")
                    .font(.system(size: 17, weight: .semibold))
            }
            Spacer()
            List{
                Section{
                    HStack{
                        Text("Focus time")
                        Spacer()
                        Text("01:28:32")
                    }
                    HStack{
                        Text("Break time")
                        Spacer()
                        Text("05:00")
                    }
                } header: {
                    Text("20.04.23")
                    
                }
                Section{
                    HStack{
                        Text("Focus time")
                        Spacer()
                        Text("25:00")
                    }
                    HStack{
                        Text("Break time")
                        Spacer()
                        Text("05:00")
                    }
                } header: {
                    Text("19.04.23")
                    
                }
                Section{
                    HStack{
                        Text("Focus time")
                        Spacer()
                        Text("25:00")
                    }
                    HStack{
                        Text("Break time")
                        Spacer()
                        Text("05:00")
                    }
                } header: {
                    Text("18.04.23")
                }
                Section{
                    HStack{
                        Text("Focus time")
                        Spacer()
                        Text("25:00")
                    }
                    HStack{
                        Text("Break time")
                        Spacer()
                        Text("05:00")
                    }
                } header: {
                    Text("17.04.23")
                }
            }
            .listStyle(.inset)
            .padding(16)
        }
    }
}

struct historyScreen_Previews: PreviewProvider {
    static var previews: some View {
        historyScreen()
    }
}

