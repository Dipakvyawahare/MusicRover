//
//  ArtistTests.swift
//  MusicRoverTests
//
//  Created by Dipak V. Vyawahare on 26/01/20.
//  Copyright © 2020 MyOrganization. All rights reserved.
//

import XCTest
@testable import MusicRover
class ArtistTests: XCTestCase, DataParser {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExampleArtistParsing() {
        guard let data = FileManager.readJson(forResource: "Sample",
                                              bundle: Bundle(for: ArtistTests.self))  else {
                                                XCTAssert(false, "Can't get data from sample.json")
                                                return
        }
        let result: Result<RawAPIResponse<Artist>, ErrorResult> = parse(data: data)
        switch result {
        case .success(let response):
            let artists = response.data!
            XCTAssertEqual(artists.count,
                           25,
                           "Parsing error or sample.json content")
            let artist = artists.first!
            XCTAssertEqual(artist.id,
                           1878,
                           "Expected 1878")
        case .failure:
            XCTAssert(false, "testExampleArtistParsing Parser Error")
        }
    }
}
