//
//  SignUp.swift
//  Merish_Sprint_2Tests
//
//  Created by Capgemini-DA202 on 9/27/22.
//

import XCTest
@testable import Merish_Sprint_2



class SignUp: XCTestCase {

    var signupTest: SignUpViewController!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        signupTest = SignUpViewController()
        signupTest.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
    }

    func test_validateemail() throws{
        XCTAssertTrue(signupTest.validateEmail(emailIdText: "meri@gmail.com"), "Email is not validated")
    }
    
    func test_validateNumber() throws{
        XCTAssertTrue(signupTest.validateNumber(mobile: "9500566074"), "password is invalid")
    }
    func test_nameoutlet() throws{
        XCTAssertNil(signupTest.signupName,"Name outlet not connected")
    }
    func testemailoutlet() throws{
        XCTAssertNil(signupTest.signupEmail,"Email outlet not connected")
    }
    func test_mobileoutlet() throws{
        XCTAssertNil(signupTest.signupmobile,"Mobile outlet not connected")
    }
    func test_passwordoutlet() throws{
        XCTAssertNil(signupTest.signupPassword,"password outlet not connected")
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
