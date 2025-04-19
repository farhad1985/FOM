//
//  TimerElapsed.swift
//  Fom
//
//  Created by Farhad Faramarzi on 07.09.24.
//

import Foundation

actor TimerElapsed {
    var second: Int = 0
    let totalSecond: Int
    
    init(totalSecond: Int) {
        self.totalSecond = totalSecond
        self.second = totalSecond
    }
    
    func countDown() {
        second -= 1
    }
    
    func reset() {
        second = totalSecond
    }
}
