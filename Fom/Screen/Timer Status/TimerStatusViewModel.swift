//
//  TimerStatusViewModel.swift
//  Fom
//
//  Created by Farhad Faramarzi on 14.09.24.
//

import Foundation

protocol TimerStatusViewModel: ObservableObject {
    var timer: String { get }
    var counter: Int { get }
    
    func subscriber()
}

final class TimerStatusViewModelImpl: TimerStatusViewModel {
    private let notificationManager: NotificationManager?
    private let timerService: TimerService?
    private let soundService: SoundService?
    private let mapper: TimerStatusMapper?
    
    @Published var timer: String = "25:00"
    @Published var counter: Int = 0

    init(
        notificationManager: NotificationManager?,
        timerService: TimerService?,
        soundService: SoundService?,
        mapper: TimerStatusMapper?
    ) {
        self.notificationManager = notificationManager
        self.timerService = timerService
        self.soundService = soundService
        self.mapper = mapper
    }
    
    func subscriber() {
        Task { @MainActor [weak self] in
            guard let streamer = self?.timerService?.timerStreamer.streamer
            else { return}
            
            for await state in streamer {
                guard let self else { return }
                switch state {
                case .countDown(let time):
                    self.updateTimer(value: time)
                    
                case .finish:
                    self.finishTimer()
                    
                case .restart:
                    self.restart()
                }
            }
        }
    }
}

private extension TimerStatusViewModelImpl {
    func finishTimer() {
        counter += 1
        notificationManager?.scheduleNotification()
        soundService?.play()
    }
    
    func updateTimer(value: Int) {
        timer = mapper?.map(seconds: value) ?? ""
    }
    
    func restart() {
        counter = 0
    }
}
