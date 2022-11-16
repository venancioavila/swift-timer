//
//  Home.swift
//  countdown
//
//  Created by Venâncio Ávila on 26/10/22.
//

import SwiftUI

struct Home: View {
    @EnvironmentObject var pomodoroModel: PomodoroModel
    
    var body: some View {
        VStack {
            Text("TIMER")
                .font(.title2.bold())
                .foregroundColor(.blue)
            CircleWatchView()
        }
        .padding()
        .background(.blue.opacity(0.15))
        .overlay(content: {
            ZStack {
                Color.black
                    .opacity(pomodoroModel.addNewTimer ? 0.25 : 0)
                    .onTapGesture {
                        pomodoroModel.hour = 0
                        pomodoroModel.minute = 0
                        pomodoroModel.seconds = 0
                        pomodoroModel.addNewTimer = false
                    }
                
                NewTimeView()
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .offset(y: pomodoroModel.addNewTimer ? 0 : 400)
            }
            .animation(.easeOut, value: pomodoroModel.addNewTimer)
        })
        .preferredColorScheme(.dark)
        .onReceive(
            Timer.publish(every: 1, on: .main, in: .common).autoconnect()) {_ in
                if pomodoroModel.isStarted {
                    pomodoroModel.updateTimer()
                }
            }
            .alert("Congratulations you did it hooray 😌", isPresented: $pomodoroModel.isFinished) {
                Button("Start new", role: .cancel) {
                    pomodoroModel.stopTimer()
                    pomodoroModel.addNewTimer = true
                }
                Button("Close", role: .destructive) {
                    pomodoroModel.stopTimer()
                }
            }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(PomodoroModel())
    }
}
