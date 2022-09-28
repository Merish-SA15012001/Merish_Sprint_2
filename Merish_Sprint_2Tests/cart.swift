//
//  cart.swift
//  Merish_Sprint_2Tests
//
//  Created by Capgemini-DA202 on 9/27/22.
//

import XCTest
@testable import Merish_Sprint_2

class cart: XCTestCase {
    var cart: Cartcheckout!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        cart = Cartcheckout()
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func test_labeloutlet() throws{
        XCTAssertNil(cart.productTitle, "title label outlet is not connected")
    }
    func test_label1outlet() throws{
        XCTAssertNil(cart.productDescription, "Description label outlet is not connected")
    }
    
    func test_imagelabeloutlet() throws{
        
        XCTAssertNil(cart.productimage, "Image outlet not connected")
    }
    
    func test_cartimage() throws{
        XCTAssertNil(cart.cartcheckoutimage, "Image outlet not connected")
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
