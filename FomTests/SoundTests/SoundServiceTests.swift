//
//  FomTests.swift
//  FomTests
//
//  Created by Farhad Faramarzi on 26.08.24.
//

import XCTest
@testable import Fom

final class SoundServiceTests: XCTestCase {
    private var sut: SoundService!
    private var soundPlayer: SoundPlayerMock!

    override func setUp() {
        super.setUp()
        
        soundPlayer = .init()
        
        sut = SoundServiceImpl(soundPlayer: soundPlayer)
    }
    
    func testPlay() {
        // Given
        sut.play()
        
        // Then
        XCTAssertEqual(soundPlayer.playerSoundCalledCount, 1)
    }
    
    func testVolume() {
        // Given
        sut.updateVolume(value: 2)
        
        // Then
        XCTAssertEqual(soundPlayer.updateVolumeCalledCount, 1)
        XCTAssertEqual(soundPlayer.updateVolumeArgument, 2)
    }
}
