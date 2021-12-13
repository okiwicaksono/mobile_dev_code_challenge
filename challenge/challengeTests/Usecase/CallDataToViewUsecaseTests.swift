//
//  CallDataToViewUsecaseTests.swift
//  challengeTests
//
//  Created by Tommy on 13/12/21.
//

import Foundation
@testable import challenge
import XCTest

class CallDataToViewUsecaseTests: XCTestCase {
    func test_showData_shouldBeNotEmpty(){
        let test = CallDataToViewUsecase(repository: JSONHelper())
        let sut = test.showDataToView()
        print(sut.count)
        XCTAssertFalse(sut.isEmpty)
    }
    
    func test_appendImageData_shouldManipulateDataImage(){
        let test = CallDataToViewUsecase(repository: JSONHelper())
        
        let sut = test.appendDataAttachment(response: JSONHelper().loadJson(filename: "message_dataset"), attachment: "image", criteria: Criteria.image)
        
        XCTAssertEqual(sut.count, 4)
        
        XCTAssertEqual(sut[0].detail.count, 4)
        XCTAssertEqual(sut[1].detail.count, 1)
        XCTAssertEqual(sut[2].detail.count, 5)

        XCTAssertEqual(sut[0].detail.last?.timestamp, "2018-12-06")
        XCTAssertEqual(sut[1].detail.last?.timestamp, "2018-12-07")
        XCTAssertEqual(sut[2].detail.last?.timestamp, "2018-12-08")

    }
    
    func test_appendContactData_shouldManipulateDataImage(){
        let test = CallDataToViewUsecase(repository: JSONHelper())
        
        let sut = test.appendDataAttachment(response: JSONHelper().loadJson(filename: "message_dataset"), attachment: "contact", criteria: Criteria.contact)
        
        XCTAssertEqual(sut.count, 3)
      
    }
}

