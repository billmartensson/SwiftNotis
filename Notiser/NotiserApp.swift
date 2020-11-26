//
//  NotiserApp.swift
//  Notiser
//
//  Created by Bill Martensson on 2020-11-26.
//

import SwiftUI
import Firebase
import FirebaseMessaging

@main
struct NotiserApp: App {
    
    init() {
        FirebaseApp.configure()
        //Messaging.messaging().delegate = self
        Messaging.messaging().isAutoInitEnabled = true
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
