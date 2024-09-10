//
//  WelcomeNotification.swift
//  buyer_app
//
//  Created by Jerry Cheng on 9/6/24.
//

import Foundation
import SwiftUI
import UserNotifications

func sendWelcomeNotification() {
    let content = UNMutableNotificationContent()
    content.title = "Welcome to GouPals!"
    content.body = "Thank you for joining us!"
    content.sound = .default

    // Trigger the notification after 1 second
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

    // Add the notification to the notification center
    UNUserNotificationCenter.current().add(request) { error in
        if let error = error {
            print("Error scheduling notification: \(error)")
        }
    }
}
