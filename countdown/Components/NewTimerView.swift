//
//  NewTimerView.swift
//  countdown
//
//  Created by Venâncio Ávila on 27/10/22.
//

import SwiftUI


struct NewTimeView: View {
    @EnvironmentObject var pomodoroModel: PomodoroModel
    
    var body: some View {
        VStack(spacing: 15) {
            Text("New timer")
                .font(.title2.bold())
                .foregroundColor(.white)
                .padding(.top, 10)
            
            HStack {
                Text("\(pomodoroModel.hour)")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.white.opacity(0.3))
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .background{
                        Capsule().fill(.white.opacity(0.2))
                    }
                    .contextMenu{
                        ContextMenuOptions(maxValue: 12, hint: "hr") {
                            value in pomodoroModel.hour = value
                        }
                    }
                
                Text("\(pomodoroModel.minute)")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.white.opacity(0.3))
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .background(Capsule()
                        .fill(.white.opacity(0.2)))
                    .contextMenu{
                        ContextMenuOptions(maxValue: 60, hint: "min") {
                            value in pomodoroModel.minute = value
                        }
                    }
                Text("\(pomodoroModel.seconds)")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.white.opacity(0.3))
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .background(Capsule()
                        .fill(.white.opacity(0.2)))
                    .contextMenu{
                        ContextMenuOptions(maxValue: 60, hint: "sec") {
                            value in pomodoroModel.seconds = value
                        }
                    }
            }
            .padding(.top, 20)
            
            Button {
                if(pomodoroModel.seconds > 0 || pomodoroModel.minute > 0 || pomodoroModel.hour > 0) {
                    pomodoroModel.startTimer()
                }
                
            } label: {
                Text("Start")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .padding(.horizontal, 100)
                    .background(Capsule().fill(.blue))
                    .padding(.top)
                    .disabled(pomodoroModel.seconds > 0 || pomodoroModel.minute > 0 || pomodoroModel.hour > 0)
                    .opacity(pomodoroModel.seconds > 0 || pomodoroModel.minute > 0 || pomodoroModel.hour > 0 ? 1 : 0.5)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background{
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(.black)
                .ignoresSafeArea()
        }
    }
}
