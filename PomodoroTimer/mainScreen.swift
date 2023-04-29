//
//  mainScreen.swift
//  PomodoroTimer
//
//  Created by Bekainar on 29.04.2023.
//

import SwiftUI

struct mainScreen: View {
    
    enum TimerMode: String {
            case initial = "Pomodoro Timer"
            case session = "Session"
            case pause = "Pause"
            case `break` = "Break"
    }

//    let sessionTime = 25 * 60
//    let breakTime = 5 * 60
    @State var sessionTime = 25 * 60
    @State var breakTime = 5 * 60
    
    @State private var focusCategory = false
    
    @State private var timerMode: TimerMode = .initial
    @State private var timerValue = 25.0 * 60
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    func startTimer() {
            switch timerMode {
            case .initial:
                timerValue = Double(sessionTime)
                timerMode = .session
            case .session:
                timerMode = .pause
            case .pause:
                timerMode = .session
            case .break:
                timerValue = Double(sessionTime)
                timerMode = .session
            }
    }
    
    func restartTimer() {
            timerMode = .initial
            timerValue = 25.0 * 60
        }
    
    func updateTimer() {
            switch timerMode {
            case .initial:
                break
            case .session:
                if timerValue > 0 {
                    timerValue -= 1
                } else {
                    timerValue = Double(breakTime)
                    timerMode = .break
                }
            case .pause:
                break
            case .break:
                if timerValue > 0 {
                    timerValue -= 1
                } else {
                    timerValue = Double(sessionTime)
                    timerMode = .session
                }
            }
        }
    func timeString(time: Double) -> String {
            let minutes = Int(time) / 60 % 60
            let seconds = Int(time) % 60
            return String(format:"%02i:%02i", minutes, seconds)
        }
        init() {
            timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        }
    
        func onDisappear() {
            timer.upstream.connect().cancel()
        }
    
    @State private var timerPlaying : Bool = false
    @State var progress: Float = 0.0
    
    var body: some View {
        ZStack{
            Image("bg2")
                .resizable()
                .ignoresSafeArea(.all)
            VStack{
                    Button(action: {
                        self.focusCategory = true
                    }) {
                        focusCategoryButton()
                    } .sheet(isPresented: $focusCategory) {
                        bottomSheetView(focusCategory: $focusCategory)
                            .presentationDetents([.medium])
                    }
                    ZStack{
                        VStack {
                            Text(timeString(time: timerValue))
                                .foregroundColor(.white)
                                .font(.system(size: 44, weight: .bold))
                                .padding(4)
                            Text("Focus on your task")
                                .foregroundColor(.white)
                        }
                        Circle()
                            .stroke(.white, lineWidth: 10)
                            .opacity(0.3)
                            .frame(width: 248, height: 248)
                        Circle()
                            .trim(from: 0.0, to: CGFloat(min(self.progress , 1.0)))
                            .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                            .frame(width: 248, height: 248)
                            .foregroundColor(.white)
                            .rotationEffect(Angle(degrees: 270))
                            .animation(.easeInOut(duration: 2.0))
                    } .padding()
                HStack(spacing: 90){
                    Button(action: {
                        startTimer()
                        timerPlaying.toggle()
                    }) {
                        if timerPlaying {
                            Image(systemName: "pause.fill")
                                .foregroundColor(.white)
                                .background(){
                                    Circle()
                                        .fill(Color.white.opacity(0.3))
                                        .frame(width: 56, height: 56)
                                }
                                .onReceive(timer) { time in
                                    if timerValue > 0 {
                                        timerValue -= 1
                                        self.progress += 0.0006
                                    }
                                }
                        } else {
                            Image(systemName: "play")
                                .foregroundColor(.white)
                                .background(){
                                    Circle()
                                        .fill(Color.white.opacity(0.3))
                                        .frame(width: 56, height: 56)
                                        .onTapGesture {
                                            onDisappear()
                                        }
                                }
                        }
                    }
                    Button(action: {
                        restartTimer()
                        self.progress = 0.0
                    }) {
                        Image(systemName: "stop.fill")
                            .padding()
                            .foregroundColor(.white)
                            .background(){
                                Circle()
                                    .fill(Color.white.opacity(0.3))
                                    .frame(width: 56, height: 56)
                            }
                    }
                    
                    
                } .padding(.top, 60)
                    
            }
        }
    }
}


struct focusCategoryButton : View {
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 16)
                .fill(.white)
                .opacity(0.3)
                .frame(width: 170, height: 36)
            HStack{
                Image(systemName: "pencil")
                Text("Focus category")
            } .padding(6)
        } .accentColor(.white)
    }
}


struct bottomSheetView : View {
    
    enum FocusCategory : Int {
        case work
        case study
        case workout
        case reading
        case meditation
        case others

        var image: UIImage {
                switch self {
                    case .work: return UIImage(named: "bg1")!
                    case .study: return UIImage(named: "bg2")!
                    case .workout: return UIImage(named: "bg3")!
                    case .reading: return UIImage(named: "bg4")!
                    case .meditation: return UIImage(named: "bg5")!
                    case .others: return UIImage(named: "bg6")!
                }
            }
    }
    
    @State private var selectedCategory: FocusCategory? = .work
    @Binding var focusCategory : Bool
    
    var body: some View{
        VStack(spacing: 20){
            HStack{
                Text("Focus Category")
                    .multilineTextAlignment(.center)
                    .padding(.leading, 140)
                Spacer()
                Image(systemName: "xmark")
                    .padding(.trailing, 16)
                    .onTapGesture {
                        focusCategory = false
                    }
            } .padding(.bottom, 40)
            HStack(spacing: 14){
                gridButtonView(title: "Work", action: {
                    selectedCategory = .work
                })
                gridButtonView(title: "Study", action: {
                    selectedCategory = .study
                })
            }
            HStack(spacing: 14){
                gridButtonView(title: "Workout", action: {
                    selectedCategory = .workout
                })
                gridButtonView(title: "Reading", action: {
                    selectedCategory = .reading
                })
            }
            HStack(spacing: 14){
                gridButtonView(title: "Meditation", action: {
                    selectedCategory = .meditation
                })
                gridButtonView(title: "Others", action: {
                    selectedCategory = .others
                })
            }
        }
    }
}

struct gridButtonView: View {
    var title : String
    var action : () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack{
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(red: 234/255, green: 234/255, blue: 234/255))
                    .frame(width: 172, height: 60)
                Text(title)
                    .foregroundColor(Color(red: 47/255, green: 47/255, blue: 51/255))
            }
        }
    }
}


struct mainScreen_Previews: PreviewProvider {
    static var previews: some View {
        mainScreen()
    }
}
