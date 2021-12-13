//
//  ViewControllerTests.swift
//  challengeTests
//
//  Created by Tommy on 13/12/21.
//

import XCTest
@testable import challenge

class ViewControllerTests: XCTestCase {
   
    func test_outlets_shouldBeConnected(){
        let sut = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: ViewController.self)) as! ViewController
        sut.loadViewIfNeeded()
        XCTAssertNotNil(sut.tableView)
        XCTAssertNotNil(sut.tableView.dataSource)
        XCTAssertNotNil(sut.tableView.delegate)

    }
    
}
