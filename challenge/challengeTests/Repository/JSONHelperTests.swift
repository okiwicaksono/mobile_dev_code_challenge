//
//  JSONHelperTests.swift
//  challengeTests
//
//  Created by Tommy on 13/12/21.
//

import XCTest
@testable import challenge

class JSONHelperTests: XCTestCase {
    private var jsonHelper: JSONHelper!
    
    override func setUp() {
        super.setUp()
        jsonHelper = JSONHelper()
    }
    
    override func tearDown() {
        jsonHelper = nil
        super.tearDown()
    }
    
    func test_JSONHelper_withTrueFileName_shouldBeNotEmptyData(){
        let sut = jsonHelper.loadJson(filename: "message_dataset")
        XCTAssertFalse(sut.data.isEmpty)
    }
    
    func test_JSONHelper_withFalseFileName_shouldBeEmptyData(){
        let sut = jsonHelper.loadJson(filename: "message")
        XCTAssertTrue(sut.data.isEmpty)
    }
    
    
    func test_JSONHelper_withFalseJsonData_shouldBeEmptyData(){
        let sut = jsonHelper.loadJson(filename: "message_dataset_false")
        XCTAssertTrue(sut.data.isEmpty)
    }
}
