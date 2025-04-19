//
//  SoundPlayerTests.swift
//  FomTests
//
//  Created by Farhad Faramarzi on 07.09.24.
//

@testable import Fom
import XCTest
import AVFoundation

final class SoundPlayerTests: XCTestCase {
    private var sut: SoundPlayer!
    
    func testSetupPlayer() throws {
        // Given
        let config = SoundConfig(soundName: "sound", volume: 1.0)
        
        // When
        sut = try AVAudioPlayer(config: config)
    }

    func testNotFoundResource() throws {
        // Given
        let config = SoundConfig(soundName: "sounda", volume: 1.0)
        
        // When
        do {
            sut = try AVAudioPlayer(config: config)
            XCTFail("the resource should not exist")
        } catch {
            let err = try XCTUnwrap(error as? SoundError)
            XCTAssertEqual(err, SoundError.notFound)
        }
    }
}
