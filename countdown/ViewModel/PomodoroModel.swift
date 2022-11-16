//
//  PomodoroModel.swift
//  countdown
//
//  Created by Venâncio Ávila on 26/10/22.
//

import SwiftUI

class PomodoroModel: NSObject, ObservableObject, UNUserNotificationCenterDelegate {
    // MARK: Time properties
    @Published var progress: CGFloat = 0.0
    @Published var timeStringValue: String = "00:00"
    @Published var isStarted: Bool = false
    @Published var addNewTimer: Bool = false
    
    @Published var hour: Int = 0
    @Published var minute: Int = 0
    @Published var seconds: Int = 0
    
    // MARK: Total seconds
    @Published var totalSeconds: Int = 0
    @Published var staticTotalSeconds: Int = 0
    
    // MARK: post time properties
    @Published var isFinished: Bool = false
    
    // MARK: since its NSObject
    override init() {
        super.init()
        self.authorizeNotifications()
    }
    
    // MARK: Starting Timer
    func startTimer() {
        withAnimation(.easeOut(duration: 0.25)){isStarted = true}
        
        // MARK: Setting string time value
        timeStringValue = "\(hour == 0 ? "" : "\(hour):")\(minute >= 10 ? "\(minute):" : "0\(minute):")\(seconds >= 10 ? "\(seconds)" : "0\(seconds)")"
        
        // MARK: calculate total seconds for time animation
        totalSeconds = (hour * 3600) + (minute * 60) + seconds
        staticTotalSeconds = totalSeconds
        
        addNewTimer = false
        
        addNotification()
    }
    
    // MARK: Stoping Timer
    func stopTimer() {
        withAnimation {
            isStarted = false
            hour = 0
            minute = 0
            seconds = 0
            progress = 0
            
            totalSeconds = 0
            staticTotalSeconds = 0
            timeStringValue = "00:00"
        }
    }
    
    // MARK: Updating Timer
    func updateTimer() {
        totalSeconds -= 1
        progress = CGFloat(totalSeconds) / CGFloat(staticTotalSeconds)
        progress = (progress < 0 ? 0 : progress)
        
        // 60 minutes * 60 seconds
        hour = totalSeconds / 3600
        minute = (totalSeconds / 60) % 60
        seconds = (totalSeconds % 60)
        
        timeStringValue = "\(hour == 0 ? "" : "\(hour):")\(minute >= 10 ? "\(minute):" : "0\(minute):")\(seconds >= 10 ? "\(seconds)" : "0\(seconds)")"
        
        if hour == 0 && minute == 0 && seconds == 0 {
            isStarted = false
            isFinished = true
        }
    }
    
    // MARK: request notification access
    func authorizeNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.sound, .alert, .badge], completionHandler: {_, _ in })
        
        // MARK: to show in app notification
        UNUserNotificationCenter.current().delegate = self
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.sound, .banner])
    }
    
    func addNotification() {
        let content = UNMutableNotificationContent()
        
        content.title = "Pomodoro timer"
        content.subtitle = "Congratulations You did it hooray 😌"
        content.sound = UNNotificationSound.default
        
        let request = UNNotificationRequest(identifier: UUID().uuidString , content: content, trigger: UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(staticTotalSeconds), repeats: false))
        
        UNUserNotificationCenter.current().add(request)
    }
}
