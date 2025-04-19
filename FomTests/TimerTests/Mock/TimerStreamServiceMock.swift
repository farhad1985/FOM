//
//  TimerStreamServiceMock.swift
//  FomTests
//
//  Created by Farhad Faramarzi on 08.09.24.
//

@testable import Fom
import Foundation

final class TimerStreamServiceMock: TimerStreamService {
    var streamer: AsyncStream<TimerState>
    var continuation: AsyncStream<TimerState>.Continuation
    
    var publishCalledCount = 0
    var publishArgumentValue: TimerState?
    
    init() {
        (streamer, continuation) = AsyncStream<TimerState>.makeStream()
    }
    
    func publish(value: TimerState) {
        publishCalledCount += 1
        publishArgumentValue = value
        continuation.yield(value)
    }
}
