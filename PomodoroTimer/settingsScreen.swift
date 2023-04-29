//
//  settingsScreen.swift
//  PomodoroTimer
//
//  Created by Bekainar on 29.04.2023.
//

import SwiftUI

struct settingsScreen: View {
    
    @State private var focustime = Date()
    @State private var BreakTime = Date()
    var body: some View {
        VStack{
            Text("Settings")
                .fontWeight(.semibold)
            DatePicker(selection: $focustime , displayedComponents: .hourAndMinute) {
                Text("Focus time")
                    .font(.system(size: 18, weight: .medium))
            }
            .datePickerStyle(.compact)
            .padding()
            DatePicker(selection: $BreakTime , displayedComponents: .hourAndMinute) {
                Text("Break time")
                    .font(.system(size: 18, weight: .medium))
            }
            .datePickerStyle(.compact)
            .padding()
            Spacer()
        }
    }
}

struct settingsScreen_Previews: PreviewProvider {
    static var previews: some View {
        settingsScreen()
    }
}

