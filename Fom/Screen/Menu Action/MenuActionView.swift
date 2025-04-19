//
//  MenuActionView.swift
//  Fom
//
//  Created by Farhad Faramarzi on 14.09.24.
//

import SwiftUI

struct MenuActionView: View {
    var timerService: TimerService?
    var analytics: FomAnalytics?

    var body: some View {
        VStack {
            Button {
                timerService?.start()
                analytics?.log(event: .start)
            } label: {
                Text("Start Focus")
            }
            
            Button {
                analytics?.log(event: .restart)
                timerService?.restart()
            } label: {
                Text("Restart Focus")
            }
            
            Button {
                analytics?.log(event: .exit)
                exit(0)
            } label: {
                Text("Exit")
            }
        }
    }
}
