//
//  LawPavillionAppUITests.swift
//  LawPavillionAppUITests
//
//  Created by Apple on 5/12/22.
//

import XCTest

class LawPavillionAppUITests: XCTestCase {

    func testPopulateTableView() {
        
        
        /*let app = XCUIApplication()
        app.launch()
        
        app/*@START_MENU_TOKEN@*/.staticTexts["Go to Solution"]/*[[".buttons[\"Go to Solution\"].staticTexts[\"Go to Solution\"]",".staticTexts[\"Go to Solution\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let searchTextField = app.textFields["Search"]
        searchTextField.tap()
        searchTextField.typeText("Dev")
        app.buttons["Search"].tap()
        let table = app.tables
        
        XCTAssertEqual(table.cells.count, 10)*/
        
        
        let app = XCUIApplication()
        app.launch()
        app/*@START_MENU_TOKEN@*/.staticTexts["Go to Solution"]/*[[".buttons[\"Go to Solution\"].staticTexts[\"Go to Solution\"]",".staticTexts[\"Go to Solution\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables["Empty list"].tap()
        app.textFields["Search"].tap()
        app.textFields["Search"].typeText("Dev")
        app.buttons["Search"].tap()
        let selectedCell = app.tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"championswimmer")/*[[".cells.containing(.staticText, identifier:\"Image url: https:\/\/avatars.githubusercontent.com\/u\/1327050?v=4\")",".cells.containing(.staticText, identifier:\"championswimmer\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .other).element.children(matching: .other).element
                
        XCTAssertNotNil(selectedCell)
    }
}
