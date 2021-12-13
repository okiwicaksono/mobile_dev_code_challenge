//
//  DetailViewControllerTests.swift
//  challengeTests
//
//  Created by Tommy on 13/12/21.
//

import Foundation
import XCTest
@testable import challenge

class DetailViewControllerTests: XCTestCase {
    func test_outlet_shouldBeConnected(){
        let sut = DetailViewController()
        sut.loadViewIfNeeded()
        XCTAssertNotNil(sut.detailLabel)
    }
}
