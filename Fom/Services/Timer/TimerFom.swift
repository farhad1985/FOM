//
//  TimerFom.swift
//  Fom
//
//  Created by Farhad Faramarzi on 08.09.24.
//

import Foundation

protocol TimerFom {
    func scheduledTimer(
        withTimeInterval interval: TimeInterval,
        block: @escaping (Timer) -> Void
    )
    func invalidate()
    func isWorking() -> Bool
}

class TimerFomImpl: TimerFom {
    private var timer: Timer?
    
    func scheduledTimer(
        withTimeInterval interval: TimeInterval,
        block: @escaping (Timer) -> Void
    ) {
        timer = Timer.scheduledTimer(
            withTimeInterval: interval,
            repeats: true,
            block: block
        )
    }
    
    func invalidate() {
        timer?.invalidate()
        timer = nil
    }
    
    func isWorking() -> Bool {
        timer != nil
    }
}
