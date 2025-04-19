//
//  NotificationManager.swift
//  Fom
//
//  Created by Farhad Faramarzi on 28.08.24.
//

import Foundation
import UserNotifications
import SwiftUI

protocol NotificationManager {
    func requestNotificationPermission()
    func scheduleNotification()
}

struct NotificationManagerImpl: NotificationManager {
    private let notificationCenter: FomNotificationCenter
    
    init(notificationCenter: FomNotificationCenter = UNUserNotificationCenter.current()) {
        self.notificationCenter = notificationCenter
    }
    
    func requestNotificationPermission() {
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error {
                print("Error requesting notification permission: \(error.localizedDescription)")
            }
        }
    }
    
    func scheduleNotification() {
        let request = makeRequest()
        notificationCenter
            .add(request) { _ in
                print("play")
            }
    }
}

private extension NotificationManagerImpl {
    func makeRequest() -> UNNotificationRequest {
        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: 1,
            repeats: false
        )
        
        let content = makeContent()
        
        return UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )
    }
    
    func makeContent() -> UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = "Hooray!!"
        content.subtitle = String(localized: "25_mins_over")
        content.body = getRandomAdvice()
        content.sound = UNNotificationSound.default
        content.badge = NSNumber(value: 1)
        
        return content
    }
    
    func getRandomAdvice() -> String {
        let ads = [
            String(localized: "drink"),
            String(localized: "walk"),
            String(localized: "music"),
            String(localized: "meditation"),
            String(localized: "look_far_away")
        ]
        
        let index = Int.random(in: 0..<ads.count)
        return ads[index]
    }
}
