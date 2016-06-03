//
//  ToddsSyndromeUITests.swift
//  ToddsSyndromeUITests
//
//  Created by Javier Roberto Manzo on 6/2/16.
//  Copyright © 2016 Javier Roberto Manzo. All rights reserved.
//

import XCTest

class ToddsSyndromeUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func addPatientTest() {
        
        let app = XCUIApplication()
        app.navigationBars["Todd's Syndrome"].buttons["Add"].tap()
        
        let addpatientButton = app.buttons["AddPatient"]
        addpatientButton.tap()
        
        let tablesQuery2 = app.tables
        let documentNumberTextField = tablesQuery2.textFields["Ingress DN"]
        documentNumberTextField.tap()
        documentNumberTextField.typeText("123")
        
        let nameTextField = tablesQuery2.textFields["Ingress name"]
        nameTextField.tap()
        nameTextField.typeText("Jason Brow")
        
        let tablesQuery = tablesQuery2
        tablesQuery.buttons["Male"].tap()
    
        tablesQuery.switches["Has Mirgranes"].tap()
        
        let doneButton = app.toolbars.buttons["Done"]
        doneButton.tap()
        addpatientButton.tap()
        
    }
    
}
