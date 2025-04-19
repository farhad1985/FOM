//
//  NotificationTests.swift
//  FomTests
//
//  Created by Farhad Faramarzi on 08.09.24.
//

@testable import Fom
import XCTest
import UserNotifications

final class NotificationTests: XCTestCase {
    private var sut: NotificationManager!
    private var userNotificationCenterMock: UNUserNotificationCenterMock!
    
    override func setUp() {
        super.setUp()
        
        userNotificationCenterMock = UNUserNotificationCenterMock()
        
        sut = NotificationManagerImpl(notificationCenter: userNotificationCenterMock)
    }
    
    func testRequestNotificationPermission() {
        // When
        sut.requestNotificationPermission()
        
        // Then
        XCTAssertEqual(userNotificationCenterMock.requestAuthorizationCalledCount, 1)
        XCTAssertEqual(userNotificationCenterMock.authorizationOptionsArgument, [.alert, .badge, .sound])
    }
    
    func testScheduleNotification() {
        // Given
        let titleExpected = "Hooray!!"
        let subtitleExpected = String(localized: "25_mins_over")
        // When
        sut.scheduleNotification()
        
        // Then
        XCTAssertEqual(userNotificationCenterMock.addCalledCount, 1)
        XCTAssertEqual(userNotificationCenterMock.requestArgument?.content.title, titleExpected)
        XCTAssertEqual(userNotificationCenterMock.requestArgument?.content.subtitle, subtitleExpected)
        XCTAssertEqual(userNotificationCenterMock.requestArgument?.content.sound, UNNotificationSound.default)
    }
}
