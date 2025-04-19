//
//  TimerStatusMapperTests.swift
//  FomTests
//
//  Created by Farhad Faramarzi on 15.09.24.
//

@testable import Fom
import XCTest

final class TimerStatusMapperTests: XCTestCase {
    private var sut: TimerStatusMapperImpl!
    
    func testCountDown() async {
        // Given
        let sut = TimerStatusMapperImpl()
        
        // When
        let result = sut.map(seconds: 9)
        
        // Then
        XCTAssertEqual(result, "00:09")
    }
    
    func testCountDownMoreThen10() async {
        // Given
        let sut = TimerStatusMapperImpl()
        
        // When
        let result = sut.map(seconds: 11)
        
        // Then
        XCTAssertEqual(result, "00:11")
    }
    
    func testCountDownFor25() async {
        // Given
        let sut = TimerStatusMapperImpl()
        
        // When
        let result = sut.map(seconds: 1500)
        
        // Then
        XCTAssertEqual(result, "25:00")
    }
}
