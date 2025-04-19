//
//  SoundService.swift
//  Fom
//
//  Created by Farhad Faramarzi on 27.08.24.
//

import AVFoundation

protocol SoundService {
    func play()
    func updateVolume(value: Float)
}

class SoundServiceImpl: SoundService {
    private var soundPlayer: SoundPlayer
    
    init(
        soundPlayer: SoundPlayer
    ) {
        self.soundPlayer = soundPlayer
    }
    
    func play() {
        soundPlayer.playSound()
    }
    
    func updateVolume(value: Float) {
        soundPlayer.updateVolume(value: value)
    }
}
