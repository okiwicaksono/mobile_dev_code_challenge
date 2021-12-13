//
//  ViewControllerTests.swift
//  challengeTests
//
//  Created by Tommy on 13/12/21.
//

import XCTest
@testable import challenge

class ViewControllerTests: XCTestCase {
    private var sut: ViewController!
    override func setUp() {
        super.setUp()
        sut = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: ViewController.self)) as? ViewController
        sut.loadViewIfNeeded()

    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    
    func test_outlets_shouldBeConnected(){
        XCTAssertNotNil(sut.tableView)
        XCTAssertNotNil(sut.tableView.dataSource)
        XCTAssertNotNil(sut.tableView.delegate)
    }
    
    func test_numberOfRowsInSection_shouldBeNotEmpty(){
        let result = sut.tableView.dataSource?.tableView(sut.tableView, numberOfRowsInSection: 0)
        XCTAssertTrue(result! > 0)
    }
    
    func test_didSelectRowAt_shouldBeClick(){
        let result: Void? = sut.tableView.delegate?.tableView?(sut.tableView, didSelectRowAt: IndexPath(row: 2, section: 1))
        XCTAssertNotNil(result)
    }
    
}
