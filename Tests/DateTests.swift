//
//  DateTests.swift
//  Tests
//
//  Created by Игорь Майсюк on 10.09.21.
//

import XCTest
@testable import ABC

class DateTests: XCTestCase {

    func testSameDayExample() throws {
        let components = DateComponents(year: 2021, month: 1, day: 7, hour: 12, minute: 23)
        guard let today = Calendar.current.date(from: components) else {
            return XCTFail("Failed to init date")
        }
        let hour = DateComponents(hour: 1)
        guard let oneHourLater = Calendar.current.date(byAdding: hour, to: today) else {
            return XCTFail("Failed to add hour")
        }
        XCTAssertFalse(oneHourLater.isOneDayPassed(since: today))
    }

    func testNextDayExample() throws {
        let components = DateComponents(year: 2021, month: 1, day: 7, hour: 12, minute: 23)
        guard let today = Calendar.current.date(from: components) else {
            return XCTFail("Failed to init date")
        }
        let day = DateComponents(day: 1)
        guard let oneDayLater = Calendar.current.date(byAdding: day, to: today) else {
            return XCTFail("Failed to add day")
        }
        XCTAssertTrue(oneDayLater.isOneDayPassed(since: today))
    }

    func testPreviousDayExample() throws {
        let components = DateComponents(year: 2021, month: 1, day: 7, hour: 12, minute: 23)
        guard let oneDayEarlier = Calendar.current.date(from: components) else {
            return XCTFail("Failed to init date")
        }
        let day = DateComponents(day: 1)
        guard let today = Calendar.current.date(byAdding: day, to: oneDayEarlier) else {
            return XCTFail("Failed to add day")
        }
        XCTAssertFalse(oneDayEarlier.isOneDayPassed(since: today))
    }

    func testPreviousMonthExample() throws {
        let components = DateComponents(year: 2021, month: 1, day: 7, hour: 12, minute: 23)
        guard let oneMonthEarlier = Calendar.current.date(from: components) else {
            return XCTFail("Failed to init date")
        }
        let month = DateComponents(month: 1)
        guard let today = Calendar.current.date(byAdding: month, to: oneMonthEarlier) else {
            return XCTFail("Failed to add day")
        }
        XCTAssertFalse(oneMonthEarlier.isOneDayPassed(since: today))
    }

    func testNextMonthExample() throws {
        let components = DateComponents(year: 2021, month: 1, day: 7, hour: 12, minute: 23)
        guard let today = Calendar.current.date(from: components) else {
            return XCTFail("Failed to init date")
        }
        let month = DateComponents(month: 1)
        guard let oneMonthLater = Calendar.current.date(byAdding: month, to: today) else {
            return XCTFail("Failed to add day")
        }
        XCTAssertTrue(oneMonthLater.isOneDayPassed(since: today))
    }

    func testPreviousMonth() throws {
        let components = DateComponents(year: 2021, month: 1, day: 7, hour: 12, minute: 23)
        guard let oneMonthEarlier = Calendar.current.date(from: components) else {
            return XCTFail("Failed to init date")
        }
        let month = DateComponents(month: 1, day: 5)
        guard let today = Calendar.current.date(byAdding: month, to: oneMonthEarlier) else {
            return XCTFail("Failed to add day")
        }
        XCTAssertFalse(oneMonthEarlier.isOneDayPassed(since: today))
    }

    func testPreviousYear() throws {
        let components = DateComponents(year: 2020, month: 12, day: 31, hour: 12, minute: 23)
        guard let yesterday = Calendar.current.date(from: components) else {
            return XCTFail("Failed to init date")
        }
        let day = DateComponents(day: 1)
        guard let today = Calendar.current.date(byAdding: day, to: yesterday) else {
            return XCTFail("Failed to add day")
        }
        XCTAssertTrue(today.isOneDayPassed(since: yesterday))
    }

    func testNextMonth() throws {
        let components = DateComponents(year: 2021, month: 1, day: 31, hour: 12, minute: 23)
        guard let today = Calendar.current.date(from: components) else {
            return XCTFail("Failed to init date")
        }
        let day = DateComponents(day: 1)
        guard let oneMonthLater = Calendar.current.date(byAdding: day, to: today) else {
            return XCTFail("Failed to add day")
        }
        XCTAssertTrue(oneMonthLater.isOneDayPassed(since: today))
    }


    func testSameDatesExample() throws {
        let today = Date()
        let anotherToday = Date()
        XCTAssertFalse(today.isOneDayPassed(since: anotherToday))
    }

}
