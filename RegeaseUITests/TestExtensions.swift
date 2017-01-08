//
//  TestExtensions.swift
//  Regease
//
//  Created by Karol Stępień on 04.01.2017.
//  Copyright © 2017 Regease. All rights reserved.
//


import XCTest

extension XCTestCase {
    
    func waitFor(element:XCUIElement, seconds waitSeconds:Double) {
        let exists = NSPredicate(format: "exists == true")
        expectation(for: exists, evaluatedWith: element, handler: nil)
        waitForExpectations(timeout: waitSeconds, handler: nil)
    }
    
    func doLogin(app: XCUIApplication) {
        let usernametextfieldTextField = XCUIApplication().textFields["usernameTextField"]
        usernametextfieldTextField.tap()
        usernametextfieldTextField.typeText("carlst")
        
        let passwordtextfieldSecureTextField = app.secureTextFields["passwordTextField"]
        passwordtextfieldSecureTextField.tap()
        passwordtextfieldSecureTextField.typeText("password")
        
        let loginbuttonButton = app.buttons["loginButton"]
        loginbuttonButton.tap()
        
        let title = app.navigationBars["Dashboard"].staticTexts["Dashboard"]
        let text = app.tables.staticTexts["Hello Karol!"]
        waitFor(element: text, seconds: 5)
        XCTAssert(text.exists)
        waitFor(element: title, seconds: 5)
        XCTAssert(title.exists)
    }
}
    
