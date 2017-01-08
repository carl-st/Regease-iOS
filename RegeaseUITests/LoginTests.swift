//
//  LoginTests.swift/Users/Karol/Documents/Development/Regis/Regis-iOS/RegeaseUITests
//  Regease
//
//  Created by Karol Stępień on 04.01.2017.
//  Copyright © 2017 Regease. All rights reserved.
//

import XCTest

class LoginTests: XCTestCase {
        
    var app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launchArguments = ["UI_TEST_MODE"]
        app.launch()
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCorrectLogin() {
        doLogin(app: app)
    }
    
}
