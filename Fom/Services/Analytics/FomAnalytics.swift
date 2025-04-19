//
//  FomAnalytics.swift
//  Fom
//
//  Created by Farhad Faramarzi on 14.09.24.
//

import Foundation
import FirebaseAnalytics

protocol FomAnalytics {
    func log(event: FomEvent)
    func log(screen: FomScreen)
}

struct FomAnalyticsImpl: FomAnalytics {
    func log(event: FomEvent) {
        Analytics.logEvent(event.value, parameters: nil)
    }
    
    func log(screen: FomScreen) {
        Analytics.logEvent(screen.value, parameters: nil)
    }
}
