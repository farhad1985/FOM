//
//  File.swift
//  Fom
//
//  Created by Farhad Faramarzi on 08.09.24.
//

import UserNotifications

protocol FomNotificationCenter {
    func requestAuthorization(options: UNAuthorizationOptions, 
                              completionHandler: @escaping (Bool, Error?) -> Void)
    
    func add(_ request: UNNotificationRequest,
             withCompletionHandler completionHandler: ((Error?) -> Void)?)
}

extension UNUserNotificationCenter: FomNotificationCenter {}
