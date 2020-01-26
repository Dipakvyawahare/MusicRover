//
//  URLExtensionsTests.swift
//  MusicRoverTests
//
//  Created by Dipak V. Vyawahare on 26/01/20.
//  Copyright © 2020 MyOrganization. All rights reserved.
//

import XCTest
@testable import MusicRover

class URLExtensionsTests: XCTestCase {

    var url = URL(string: "https://www.mysite.com")!
    let params = ["query1": "hitMyfunction"]
    let queryUrl = URL(string: "https://www.mysite.com?query1=hitMyfunction")!
    
    func testAppendingQueryParameters() {
        XCTAssertEqual(url.appendParameters(params: params), queryUrl)
    }
}
