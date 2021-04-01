//
//  MusicRoverUITests.swift
//  MusicRoverUITests
//
//  Created by Dipak V. Vyawahare on 25/01/20.
//  Copyright © 2020 MyOrganization. All rights reserved.
//

import XCTest

class MusicRoverUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    @discardableResult
    func waiterResultWithExpextation(_ element: XCUIElement) -> XCTWaiter.Result {
        let myPredicate = NSPredicate(format: "exists == true")
        let myExpectation = expectation(for: myPredicate, evaluatedWith: element,
                                        handler: nil)
        let result = XCTWaiter().wait(for: [myExpectation], timeout: 5)
        return result
    }
    
    func testHappyFlow() {
        let pKey = app.keys["P"]
        pKey.tap()
        
        let cell = app.cells.element(boundBy: 0)
        waiterResultWithExpextation(cell)
        XCTAssertTrue(cell.exists)
        cell.tap()
        
        let firstCell = app.collectionViews.children(matching: .cell).element(boundBy: 0)
        waiterResultWithExpextation(firstCell)
        XCTAssertTrue(firstCell.exists)
        firstCell.tap()
        
        let imageView = app.images["AlbumImageView"]
        waiterResultWithExpextation(imageView)
        XCTAssertTrue(imageView.exists)
    }
}
