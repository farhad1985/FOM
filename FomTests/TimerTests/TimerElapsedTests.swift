//
//  TimerElapsedTests.swift
//  FomTests
//
//  Created by Farhad Faramarzi on 07.09.24.
//

@testable import Fom
import XCTest

final class TimerElapsedTests: XCTestCase {
    func testCountDown() async {
        // Given
        let sut = TimerElapsed(totalSecond: 2)

        // When
        await sut.countDown()
        
        // Then
        let second = await sut.second
        XCTAssertEqual(second, 1)
    }
}
