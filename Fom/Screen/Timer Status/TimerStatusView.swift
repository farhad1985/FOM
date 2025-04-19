//
//  ContentView.swift
//  Fom
//
//  Created by Farhad Faramarzi on 26.08.24.
//

import SwiftUI
import Foundation

struct TimerStatusView<ViewModel: TimerStatusViewModel>: View {
    @ObservedObject var viewModel: ViewModel

    init(vm: ViewModel) {
        viewModel = vm
    }

    var body: some View {
        HStack {
            Image(systemName: "\(viewModel.counter).circle.fill")
            Text(viewModel.timer)
        }
        .task {
            viewModel.subscriber()
        }
    }
}
