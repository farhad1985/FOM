//
//  UNUserNotificationCenterMock.swift
//  FomTests
//
//  Created by Farhad Faramarzi on 08.09.24.
//

@testable import Fom
import UserNotifications


final class UNUserNotificationCenterMock: FomNotificationCenter {
    var authorizationOptionsArgument: UNAuthorizationOptions = []
    var requestArgument: UNNotificationRequest?

    var requestAuthorizationCalledCount = 0
    var addCalledCount = 0
    
    class func shared() -> UNUserNotificationCenter {
        UNUserNotificationCenter.current()
    }

    func requestAuthorization(options: UNAuthorizationOptions = [],
                                       completionHandler: @escaping (Bool, (any Error)?) -> Void) {
        authorizationOptionsArgument = options
        requestAuthorizationCalledCount += 1
    }
    
    func add(_ request: UNNotificationRequest, withCompletionHandler completionHandler: (((any Error)?) -> Void)? = nil) {
        
        addCalledCount += 1
        requestArgument = request
    }
}
