//
//  TimerServiceTests.swift
//  FomTests
//
//  Created by Farhad Faramarzi on 08.09.24.
//

@testable import Fom
import XCTest

final class TimerServiceTests: XCTestCase {
    private var timerStreamServiceMock: TimerStreamServiceMock!
    private var timerFomMock: TimerFomMock!
    
    override func tearDown() {
        super.tearDown()
        
        timerStreamServiceMock = nil
        timerFomMock = nil
    }
    
    @MainActor
    func testStartTimer() async throws {
        // Given
        let sut: TimerService = makeSUT()
        // When
        sut.start()
        try await Task.sleep(nanoseconds: 100000000)

        
        XCTAssertEqual(timerStreamServiceMock.publishCalledCount, 1)
        XCTAssertEqual(timerFomMock.isWorkingCount, 1)
        XCTAssertEqual(timerStreamServiceMock.publishArgumentValue, .countDown(1))
    }
    
    @MainActor
    func testStartTimerWhenTimerIsWorking() async throws {
        // Given
        let sut: TimerService = makeSUT()
        // When
        sut.start()
        timerFomMock.isWorkingValue = true
        sut.start()
        sut.start()

        try await Task.sleep(nanoseconds: 100000000)

        
        XCTAssertEqual(timerStreamServiceMock.publishCalledCount, 1)
        XCTAssertEqual(timerFomMock.isWorkingCount, 3)
        XCTAssertEqual(timerStreamServiceMock.publishArgumentValue, .countDown(1))
    }
    
    @MainActor
    func testInavlideTimer() async throws {
        // Given
        let sut = makeSUT(seconds: 1)

        // When
        sut.start()
        try await Task.sleep(nanoseconds: 100000000)

        // Then
        XCTAssertEqual(timerStreamServiceMock.publishCalledCount, 2)
        XCTAssertEqual(timerStreamServiceMock.publishArgumentValue, .finish)
        XCTAssertEqual(timerFomMock.invalidateCalledCount, 1)
    }
}

private extension TimerServiceTests {
    func makeSUT(seconds: Int = 2) -> TimerServiceImpl {
        let config = TimerConfig(seconds: seconds)
        timerStreamServiceMock = .init()
        timerFomMock = .init()
        
        return TimerServiceImpl(
            config: config,
            timer: timerFomMock,
            timerStreamer: timerStreamServiceMock
        )
    }
}
