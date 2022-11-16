//
//  CircleWatchView.swift
//  countdown
//
//  Created by Venâncio Ávila on 27/10/22.
//

import SwiftUI

struct CircleWatchView: View {
    @EnvironmentObject var pomodoroModel: PomodoroModel
    
    var body: some View {
        GeometryReader { proxy in
            VStack(spacing: 15) {
                // MARK: Timer ring
                Spacer()
                ZStack {
                   Circle()
                        .fill(.white.opacity(0.1))
                        .padding(-40)
                    
                    Circle()
                        .trim(from: 0, to: pomodoroModel.progress)
                        .stroke(.white.opacity(0.2), lineWidth: 80)
                        .blur(radius: 2)
                    
                    // MARK: Shadow
                    Circle()
                        .stroke(.blue, lineWidth: 10)
                        .blur(radius: 15)
                    
                    Circle()
                        .fill(.blue.opacity(0.8))
                    
                    Circle()
                        .trim(from: 0, to: pomodoroModel.progress)
                        .stroke(.green.opacity(0.7), lineWidth: 10)
                    
                    // MARK: Knob
                    GeometryReader {proxy in
                        let size = proxy.size
                        Circle()
                            .fill(.green)
                            .frame(width: 30, height: 30)
                            .overlay(content: {
                                Circle()
                                    .fill(.white)
                                    .padding(5)
                            })
                            .frame(width: size.width, height: size.height, alignment: .center)
                            // MARK: Sice View is rotate thats why using X
                            .offset(x: size.height / 2)
                            .rotationEffect(.init(degrees: pomodoroModel.progress * 360))
                    }
                    
                    Text(pomodoroModel.timeStringValue)
                        .font(.largeTitle)
                        .rotationEffect(Angle(degrees: 90))
                        .animation(.none, value: pomodoroModel.progress)
                }
                .padding(60)
                .frame(height: proxy.size.width)
                .rotationEffect(.init(degrees: -90))
                .animation(.easeOut, value: pomodoroModel.progress)
                
                Spacer()
                
                Button{
                    if(pomodoroModel.isStarted) {
                        pomodoroModel.stopTimer()
                        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                    } else {
                        pomodoroModel.addNewTimer = true
                    }
                } label: {
                    Image(systemName: pomodoroModel.isStarted ? "stop.fill" : "play.fill")
                        .font(.largeTitle.bold())
                        .foregroundColor(.white)
                        .frame(width: 80, height: 80)
                        .background(Circle().fill(.blue))
                }
                .shadow(color: .blue, radius: 8, x: 0, y: 0)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
    }
}
