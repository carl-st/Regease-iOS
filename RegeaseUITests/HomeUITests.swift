//
//  RegeaseUITests.swift
//  RegeaseUITests
//
//  Created by Karol Stępień on 27.11.2016.
//  Copyright © 2016 Regease. All rights reserved.
//

import XCTest

class HomeTests: XCTestCase {
        
    var app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launchArguments = ["UI_TEST_MODE"]
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testTabBar() {
        doLogin(app: app)
        let tabBarsQuery = app.tabBars
        
        tabBarsQuery.children(matching: .button).element(boundBy: 0).tap()
        var title  = app.navigationBars["Dashboard"].staticTexts["Dashboard"]
        XCTAssert(title.exists)
        
        tabBarsQuery.children(matching: .button).element(boundBy: 1).tap()
        title = app.navigationBars["Calendar"].staticTexts["Calendar"]
        XCTAssert(title.exists)
        
        tabBarsQuery.children(matching: .button).element(boundBy: 2).tap()
        title = app.navigationBars["Settings"].staticTexts["Settings"]
        XCTAssert(title.exists)
    }
    
    func testSettingsFlow() {
        
// Appearance
        doLogin(app: app)
        app.tabBars.children(matching: .button).element(boundBy: 2).tap()
        var title = app.navigationBars["Settings"].staticTexts["Settings"]
        XCTAssert(title.exists)
        
        app.tables.staticTexts["Appearance"].tap()
        title = app.navigationBars["Appearance"].staticTexts["Appearance"]
        XCTAssert(title.exists)
        
        let titleTextField = app.staticTexts["Title & description"]
        XCTAssert(titleTextField.exists)
        
        var label = app.staticTexts["Visible title and description"]
        XCTAssert(label.exists)
        
        label = app.staticTexts["Theme colors"]
        XCTAssert(label.exists)
        
        var button = app.buttons["Save"]
        XCTAssert(button.exists)
        
        XCUIApplication().navigationBars["Appearance"].buttons["Settings"].tap()
        title = app.navigationBars["Settings"].staticTexts["Settings"]
        XCTAssert(title.exists)
        
// Calendar
        app.tables.staticTexts["Calendar"].tap()
        
        let calendarNavigationBar = app.navigationBars["Calendar"]
        title = calendarNavigationBar.staticTexts["Calendar"]
        XCTAssert(title.exists)
        
        label = app.staticTexts["Working days"]
        XCTAssert(label.exists)
        
        label = app.staticTexts["Working hours"]
        XCTAssert(label.exists)
        
        button = app.buttons["Start"]
        XCTAssert(button.exists)
        
        button = app.buttons["End"]
        XCTAssert(button.exists)
        
        button = app.buttons["Save"]
        XCTAssert(button.exists)
        
        XCUIApplication().navigationBars["Calendar"].buttons["Settings"].tap()
        title = app.navigationBars["Settings"].staticTexts["Settings"]
        XCTAssert(title.exists)
        
// Visits
        let tablesQuery = app.tables
        let visitsStaticText = tablesQuery.staticTexts["Visits"]
        visitsStaticText.tap()
        
        let visitsNavigationBar = app.navigationBars["Visits"]
        visitsNavigationBar.staticTexts["Visits"].tap()

        let cell = tablesQuery.staticTexts["Surgery"]
        XCTAssert(cell.exists)
        
        button = app.buttons["Add"]
        XCTAssert(button.exists)
        
        button = app.buttons["Remove"]
        XCTAssert(button.exists)
        
        button = app.buttons["Save"]
        XCTAssert(button.exists)
        
        XCUIApplication().navigationBars["Visits"].buttons["Settings"].tap()
        title = app.navigationBars["Settings"].staticTexts["Settings"]
        XCTAssert(title.exists)
    }
    
    func testCalendarFlow() {
        doLogin(app: app)
        app.tabBars.children(matching: .button).element(boundBy: 1).tap()
        app.collectionViews.children(matching: .cell).element(boundBy: 10).children(matching: .other).element.tap()
        
        app.tables.staticTexts["John Travolta"].tap()
        var title = app.navigationBars["Details"].staticTexts["Details"]
        XCTAssert(title.exists)
        
        app.navigationBars["Details"].buttons["Calendar"].tap()
        title = app.navigationBars["Calendar"].staticTexts["Calendar"]
        XCTAssert(title.exists)
    }
    
    func testDashboardFlow() {
        doLogin(app: app)
        app.tabBars.children(matching: .button).element(boundBy: 0).tap()
        app.navigationBars["Dashboard"].staticTexts["Dashboard"].tap()
        
        let tablesQuery2 = app.tables
        let tablesQuery = tablesQuery2
        
        var label = tablesQuery.staticTexts["John Travolta"]
        label = tablesQuery.staticTexts["Consultation"]
        app.tables.cells.containing(.staticText, identifier:"3:44 PM - 3:44 PM").children(matching: .button).element.tap()
        
        app.tables.otherElements["dashboardCard"].tap()
        
        let detailsNavigationBar = app.navigationBars["Details"]
        var title = detailsNavigationBar.staticTexts["Details"]
        XCTAssert(title.exists)
        
        detailsNavigationBar.buttons["Dashboard"].tap()
        title = app.navigationBars["Dashboard"].staticTexts["Dashboard"]
        XCTAssert(title.exists)
    }

}
