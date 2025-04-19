//
//  FomApp.swift
//  Fom
//
//  Created by Farhad Faramarzi on 26.08.24.
//

import SwiftUI
import AVFoundation
import FirebaseCore

@main
struct FomApp: App {
    @AppStorage("showMenuBarExtra") private var showMenuBarExtra = true
        
    private var timerService: TimerService?
    private var notificationManager: NotificationManager?
    private var soundService: SoundService?
    private var analytics: FomAnalytics?

    init() {
        analytics = FomAnalyticsImpl()
        setupNotificationManager()
        setupTimer()
        setupPlayer()
        setupFirebase()
        
        analytics?.log(screen: .startScreen)
    }
    
    var body: some Scene {
        MenuBarExtra {
            MenuActionView(
                timerService: timerService,
                analytics: analytics
            )
        } label: {
            TimerStatusView(
                vm: TimerStatusViewModelImpl(
                    notificationManager: notificationManager,
                    timerService: timerService,
                    soundService: soundService, 
                    mapper: TimerStatusMapperImpl()
                )
            )
        }
    }
}

private extension FomApp {
    mutating func setupPlayer() {
        do {
            let config = SoundConfig(soundName: "sound", volume: 1.0)
            let player: SoundPlayer = try AVAudioPlayer(config: config)
            soundService = SoundServiceImpl(soundPlayer: player)
        } catch SoundError.notFound {
            print("Error: \nSound Service: Not Found Resource")
        } catch {
            print("Error: \nSound Service: \(error.localizedDescription)")
        }
    }
    
    mutating func setupTimer() {
        var seconds = 0
#if DEBUG
        seconds = 3
#else
        seconds = 1500
#endif
        let config = TimerConfig(seconds: seconds)
        let timerStreamer = TimerStreamServiceImpl()
        let timer: TimerFom = TimerFomImpl()
        timerService = TimerServiceImpl(
            config: config,
            timer: timer,
            timerStreamer: timerStreamer
        )
    }
    
    mutating func setupNotificationManager() {
        notificationManager = NotificationManagerImpl()
        notificationManager?.requestNotificationPermission()
    }
    
    func setupFirebase() {
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
            print("Firebase is configured")
        } else {
            print("Firebase is already configured")
        }
    }
}
