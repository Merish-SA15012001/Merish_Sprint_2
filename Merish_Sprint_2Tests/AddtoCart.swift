//
//  AddtoCart.swift
//  Merish_Sprint_2Tests
//
//  Created by Capgemini-DA202 on 9/27/22.
//

import XCTest
@testable import Merish_Sprint_2

class AddtoCart: XCTestCase {
    var addtocart: ProductDetail!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        addtocart = ProductDetail()
    }
    func test_outlet() throws{
        XCTAssertNil(addtocart.itemtitle, "Outlet not connected")
    }
    func test_labeloutlet() throws{
        XCTAssertNil(addtocart.itemDescription, "Outlet not connected")
    }
    func test_imageoutlet() throws{
        XCTAssertNil(addtocart.productimage, "Outlet not connected")
    }
    func test_cartoutlet() throws{
        XCTAssertNil(addtocart.cartimage, "Outlet not connected")
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
