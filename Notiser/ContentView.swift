//
//  ContentView.swift
//  Notiser
//
//  Created by Bill Martensson on 2020-11-26.
//

import SwiftUI
import UserNotifications
import CoreLocation

struct ContentView: View {
    
    
    
    var body: some View {
        VStack {
            Text("Hello, world!")
                .padding()
            
            Button(action: {
                setupNotification()
            }) {
                Text("Starta notiser")
            }.padding()
            
            Button(action: {
                scheduleNotification()
            }) {
                Text("Skapa notis")
            }.padding()
            
        }
    }
    
    
    func setupNotification()
    {
        let notificationCenter = UNUserNotificationCenter.current()
        
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        
        notificationCenter.requestAuthorization(options: options) {
            (didAllow, error) in
            if !didAllow {
                print("User has declined notifications")
            }
        }
        
        UIApplication.shared.registerForRemoteNotifications()
        
        UIApplication.shared.applicationIconBadgeNumber = 0
        
        let locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        
    }
    
    func scheduleNotification() {
        
        let content = UNMutableNotificationContent() // Содержимое уведомления
        
        content.body = "Exempel body"
        content.title = "Exempel titel"
        content.subtitle = "Exempel subtitel"
        content.sound = UNNotificationSound.default
        content.badge = 42
        
        //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let center = CLLocationCoordinate2D(latitude: 37.335400, longitude: -122.009201)
        let region = CLCircularRegion(center: center, radius: 2000.0, identifier: "Headquarters")
        region.notifyOnEntry = true
        region.notifyOnExit = false
        let trigger = UNLocationNotificationTrigger(region: region, repeats: false)
        
        
        
        let identifier = "ABC"
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)

        let notificationCenter = UNUserNotificationCenter.current()
        
        notificationCenter.add(request) { (error) in
            if let error = error {
                print("Error \(error.localizedDescription)")
            }
        }
        
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
