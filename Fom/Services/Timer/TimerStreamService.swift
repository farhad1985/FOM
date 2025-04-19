//
//  TimerStreamService.swift
//  Fom
//
//  Created by Farhad Faramarzi on 07.09.24.
//

import Foundation

enum TimerState: Equatable {
    case countDown(Int)
    case finish
    case restart
}

protocol TimerStreamService {
    var streamer: AsyncStream<TimerState> { get }
    
    func publish(value: TimerState)
}

struct TimerStreamServiceImpl: TimerStreamService {
    let streamer: AsyncStream<TimerState>
    private let continuation: AsyncStream<TimerState>.Continuation
    
    init() {
        (streamer, continuation) = AsyncStream<TimerState>.makeStream()
    }

    func publish(value: TimerState) {
        continuation.yield(value)
    }
}
