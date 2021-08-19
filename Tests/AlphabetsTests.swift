//
//  AlphabetsTests.swift
//  ABC
//
//  Created by Игорь Майсюк on 17.08.21.
//

import XCTest
@testable import ABC

class AlphabetsTests: XCTestCase {

    private var sut: Alphabet?

    override func setUpWithError() throws {
        sut = English()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testFirstA() throws {
        let zero = IndexPath(item: 0, section: 0)
        XCTAssertEqual(sut?.letter(at: zero), Letter(symbol: "a"))
    }

    func testSecondB() throws {
        let zero = IndexPath(item: 1, section: 0)
        XCTAssertEqual(sut?.letter(at: zero), Letter(symbol: "b"))
    }

    func testSixF() throws {
        let zero = IndexPath(item: 5, section: 0)
        XCTAssertEqual(sut?.letter(at: zero), Letter(symbol: "f"))
    }

    func testEightH() throws {
        let zero = IndexPath(item: 1, section: 1)
        XCTAssertEqual(sut?.letter(at: zero), Letter(symbol: "h"))
    }

    func testO() throws {
        let zero = IndexPath(item: 2, section: 2)
        XCTAssertEqual(sut?.letter(at: zero), Letter(symbol: "o"))
    }

    func testQ() throws {
        let zero = IndexPath(item: 4, section: 2)
        XCTAssertEqual(sut?.letter(at: zero), Letter(symbol: "q"))
    }

    func testV() throws {
        let zero = IndexPath(item: 4, section: 3)
        XCTAssertEqual(sut?.letter(at: zero), Letter(symbol: "v"))
    }

    func testZ() throws {
        let zero = IndexPath(item: 3, section: 4)
        XCTAssertEqual(sut?.letter(at: zero), Letter(symbol: "z"))
    }

    func testIndexOvercome() throws {
        let zero = IndexPath(item: 10, section: 4)
        XCTAssertEqual(sut?.letter(at: zero), Letter(symbol: "a"))
    }

    func testRowOvercome() throws {
        let zero = IndexPath(item: 0, section: 10)
        XCTAssertEqual(sut?.letter(at: zero), Letter(symbol: "a"))
    }

    func testRowOvercomeTotal() throws {
        let zero = IndexPath(item: 4, section: 10)
        XCTAssertEqual(sut?.letter(at: zero), Letter(symbol: "a"))
    }

    // MARK: - Letters in row

    func testFirstRowABCDEF() {
        let letters = "abcdef".map { Letter(symbol: $0) }
        XCTAssertEqual(sut?.letters(in: 0), letters)
    }

    func testSecondRowABCDEF() {
        let letters = "ghijkl".map { Letter(symbol: $0) }
        XCTAssertEqual(sut?.letters(in: 1), letters)
    }

    func testLastRowWXYZ() {
        let letters = "wxyz".map { Letter(symbol: $0) }
        XCTAssertEqual(sut?.letters(in: 4), letters)
    }

    func testRowTooHigh() {
        XCTAssertEqual(sut?.letters(in: 100), [])
    }

    func testRowNegative() {
        XCTAssertEqual(sut?.letters(in: -1), [])
    }

}
