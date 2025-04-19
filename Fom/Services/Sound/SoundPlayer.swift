//
//  SoundPlayer.swift
//  Fom
//
//  Created by Farhad Faramarzi on 07.09.24.
//

import AVFoundation

enum SoundError: Error {
    case notFound
}

protocol SoundPlayer {
    func playSound()
    func updateVolume(value: Float)
}

extension AVAudioPlayer: SoundPlayer {
    convenience init(config: SoundConfig) throws {
        guard let soundURL = Bundle.main.url(
            forResource: config.soundName,
            withExtension: "mp3"
        )
        else {
            throw SoundError.notFound
        }
        
        try self.init(contentsOf: soundURL)
    }
    
    func updateVolume(value: Float) {
        volume = value
    }
    
    func playSound() {
        prepareToPlay()
        play()
    }
}
