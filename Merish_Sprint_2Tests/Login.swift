//
//  Login.swift
//  Merish_Sprint_2Tests
//
//  Created by Capgemini-DA202 on 9/27/22.
//

import XCTest
@testable import Merish_Sprint_2
class Login: XCTestCase {

    var loginTest: ViewController!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        loginTest = ViewController()
        loginTest.loadViewIfNeeded()
    }
    func test_emailoutlet() throws{
        XCTAssertNil(loginTest.LoginEmail, "Loginemail is not connected")
    }
    
    func test_passwordoutlet() throws{
        XCTAssertNil(loginTest.LoginPassword, "Password outlet is not connected")
    }
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
