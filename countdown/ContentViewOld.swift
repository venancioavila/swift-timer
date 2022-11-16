//
//  ContentView.swift
//  countdown
//
//  Created by Venâncio Ávila on 26/10/22.
//



import SwiftUI
import UserNotifications

struct ContentViewOld: View {
    @State var timeRemaining = 0.0
    @State var isActive: Bool = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("All set!")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func sendNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Feed the cat"
        content.subtitle = "It looks hungry"
        content.sound = UNNotificationSound.default

        // show this notification five seconds from now
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

        // choose a random identifier
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        // add our notification request
        UNUserNotificationCenter.current().add(request)
    }
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Text("\(Int(timeRemaining))")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
                Spacer()
                
                Slider(value: $timeRemaining, in: 0...120){}
                
                Button("Start", action: {isActive.toggle()})
                
                Button("Request Permission") {
                    requestPermission()
                }
                
                Button("Send notification") {
                    requestPermission()
                }
                
                if(timeRemaining == 0) {
                    Button("Restart", action: {
                        timeRemaining = 11
                    })
                }
            }
        }
        .onReceive(timer) { time in
            guard isActive else { return }
            if timeRemaining > 0 {
                timeRemaining -= 1
            }
        }
        .padding()
    }
}

struct ContentViewOld_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
