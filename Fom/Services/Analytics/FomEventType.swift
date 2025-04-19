//
//  FomEventType.swift
//  Fom
//
//  Created by Farhad Faramarzi on 14.09.24.
//

import Foundation

enum FomEvent: String {
    case start = "start_action"
    case restart = "restart_action"
    case exit = "exit_action"
    
    var value: String {
        self.rawValue
    }
}

enum FomScreen: String {
    case startScreen = "start_screen"
    
    var value: String {
        self.rawValue
    }
}
