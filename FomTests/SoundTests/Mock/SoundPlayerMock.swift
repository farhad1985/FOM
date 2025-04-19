//
//  SoundPlayerMock.swift
//  FomTests
//
//  Created by Farhad Faramarzi on 07.09.24.
//

@testable import Fom

class SoundPlayerMock: SoundPlayer {
    var playerSoundCalledCount: Int = 0
    var updateVolumeCalledCount: Int = 0
    
    var updateVolumeArgument: Float = 0

    func playSound() {
        playerSoundCalledCount += 1
    }
    
    func updateVolume(value: Float) {
        updateVolumeCalledCount += 1
        updateVolumeArgument = value
    }
}
