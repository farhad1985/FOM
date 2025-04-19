//
//  TimerFomTests.swift
//  FomTests
//
//  Created by Farhad Faramarzi on 15.09.24.
//

@testable import Fom
import XCTest

final class TimerFomTests: XCTestCase {
    private var sut: TimerFom!
    
    override func setUp() {
        super.setUp()
        
        sut = TimerFomImpl()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    @MainActor
    func testStartTimer() async throws {
        // Given
        let exp = expectation(description: "start timer")

        // When
        sut.scheduledTimer(withTimeInterval: 1) { _ in
            // Then
            XCTAssertTrue(self.sut.isWorking())
            exp.fulfill()
        }
        
        await fulfillment(of: [exp], timeout: 2)
    }
    
    @MainActor
    func testInvalidTimer() async throws {
        // Given
        let exp = expectation(description: "start timer")
        
        // When
        sut.scheduledTimer(withTimeInterval: 1) { _ in
            self.sut.invalidate()
            exp.fulfill()
        }

        await fulfillment(of: [exp], timeout: 2)
        
        // Then
        XCTAssertFalse(sut.isWorking())
    }
}
