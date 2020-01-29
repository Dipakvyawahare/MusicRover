//
//  ArtistTests.swift
//  MusicRoverTests
//
//  Created by Dipak V. Vyawahare on 26/01/20.
//  Copyright © 2020 MyOrganization. All rights reserved.
//

import XCTest
@testable import MusicRover
class AlbumsTests: XCTestCase, DataParser {

    func testExampleArtistParsing() {
        guard let data = FileManager.readJson(forResource: "Albums",
                                              bundle: Bundle(for: ArtistTests.self))  else {
                                                XCTAssert(false, "Can't get data from sample.json")
                                                return
        }
        let result: Result<RawAPIResponse<Album>, ErrorResult> = parse(data: data)
        switch result {
        case .success(let response):
            let artists = response.data!
            XCTAssertEqual(artists.count,
                           25,
                           "Parsing error or Albums.json content")
            let artist = artists.first!
            XCTAssertEqual(artist.id,
                           80513002,
                           "Expected 80513002")
        case .failure:
            XCTAssert(false, "testExampleArtistParsing Parser Error")
        }
    }
}
