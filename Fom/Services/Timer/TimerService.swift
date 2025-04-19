//
//  TimerService.swift
//  Fom
//
//  Created by Farhad Faramarzi on 26.08.24.
//

import Foundation
import AppKit

protocol TimerService {
    var timerStreamer: TimerStreamService { get }
    func start()
    func restart()
}

class TimerServiceImpl: TimerService {
    var timerStreamer: TimerStreamService
    
    private var timerElapsed: TimerElapsed
    private var timer: TimerFom
    private var task: Task<Void, Never>?
    
    init(
        config: TimerConfig,
        timer: TimerFom,
        timerStreamer: TimerStreamService
    ) {
        timerElapsed = TimerElapsed(totalSecond: config.seconds)
        self.timerStreamer = timerStreamer
        self.timer = timer
    }
    
    func start() {
        guard !timer.isWorking() else { return }
        scheduleTimer()
    }
    
    func restart() {
        timerStreamer.publish(value: .restart)
    }
}

private extension TimerServiceImpl {
    
    func scheduleTimer() {
        timer.scheduledTimer(withTimeInterval: 1) { [weak self] _ in
            self?.task = Task { [weak self] in
                guard let self = self else { return }
                await self.countDown()
                await self.updateTimer()
                await self.checkTimer()
            }
        }
    }
    
    func stop() async {
        timer.invalidate()
        timerStreamer.publish(value: .finish)
        await timerElapsed.reset()
        task?.cancel()
    }
    
    func countDown() async {
        await timerElapsed.countDown()
    }
    
    func updateTimer() async {
        let time = await timerElapsed.second
        timerStreamer.publish(value: .countDown(time))
    }
    
    func checkTimer() async {
        if await timerElapsed.second <= 0 {
            await stop()
        }
    }
}
