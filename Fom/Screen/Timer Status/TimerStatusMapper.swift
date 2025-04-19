//
//  TimerStatusMapper.swift
//  Fom
//
//  Created by Farhad Faramarzi on 14.09.24.
//

import Foundation

protocol TimerStatusMapper {
    func map(seconds: Int) -> String
}

struct TimerStatusMapperImpl: TimerStatusMapper {
    func map(seconds: Int) -> String {
        let minutes = (seconds % 3600) / 60
        let seconds = (seconds % 3600) % 60
        
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
