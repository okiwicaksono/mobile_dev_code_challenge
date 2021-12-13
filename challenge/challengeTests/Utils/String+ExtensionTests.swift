//
//  String+ExtensionTests.swift
//  challengeTests
//
//  Created by Tommy on 13/12/21.
//

import XCTest
@testable import challenge

class String_ExtensionTests: XCTestCase {
    func test_formatToDate_with1544086218_shouldBeDate(){
        let sut = "1544086218".formatToDate()
        XCTAssertEqual(sut.date.debugDescription, "2018-12-06 08:50:18 +0000")
        XCTAssertEqual(sut.dateString, "2018-12-06")

    }

}
