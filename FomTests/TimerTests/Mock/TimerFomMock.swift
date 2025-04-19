//
//  TImerFomMock.swift
//  FomTests
//
//  Created by Farhad Faramarzi on 08.09.24.
//

@testable import Fom
import Foundation

final class TimerFomMock: TimerFom {
    var isWorkingCount = 0
    var isWorkingValue = false
    
    var invalidateCalledCount = 0
    var scheduledTimerCalledCount = 0

    var scheduledTimerBlock: ((Timer) -> Void)?
    
    func scheduledTimer(
        withTimeInterval interval: TimeInterval,
        block: @escaping (Timer) -> Void
    ) {
        scheduledTimerCalledCount += 1
        block(Timer())
    }
    
    func invalidate() {
        invalidateCalledCount += 1
    }
    
    func isWorking() -> Bool {
        isWorkingCount += 1
        return isWorkingValue
    }
}
