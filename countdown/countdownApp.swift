//
//  countdownApp.swift
//  countdown
//
//  Created by Venâncio Ávila on 26/10/22.
//

import SwiftUI

@main
struct countdownApp: App {
    @StateObject var pomodoroModel: PomodoroModel = .init()
    
    // MARK: Scene Pahse
    @Environment(\.scenePhase) var phase
    
    // MARK: Storing last time stamp
    @State var lastActiveTimeStamp: Date = Date()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(pomodoroModel)
        }
        .onChange(of: phase, perform: { newValue in
            if pomodoroModel.isStarted {
                if newValue == .background {
                    lastActiveTimeStamp = Date()
                }
                
                if newValue == .active {
                    // MARK: find the difference
                    let currentTimeStapDiff = Date().timeIntervalSince(lastActiveTimeStamp)
                    
                    if pomodoroModel.totalSeconds - Int(currentTimeStapDiff) <= 0 {
                        pomodoroModel.isStarted = false
                        pomodoroModel.totalSeconds = 0
                        pomodoroModel.isFinished = true
                    } else {
                        pomodoroModel.totalSeconds -= Int(currentTimeStapDiff)
                    }
                    
                }
            }
        })
    }
}
