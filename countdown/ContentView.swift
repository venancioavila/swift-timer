//
//  ContentView.swift
//  countdown
//
//  Created by Venâncio Ávila on 26/10/22.
//



import SwiftUI
import UserNotifications

struct ContentView: View {
    @EnvironmentObject var pomodoroModel: PomodoroModel
    
    var body: some View {
        Home()
            .environmentObject(pomodoroModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(PomodoroModel())
    }
}
