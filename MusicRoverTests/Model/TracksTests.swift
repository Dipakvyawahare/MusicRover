//
//  ArtistTests.swift
//  MusicRoverTests
//
//  Created by Dipak V. Vyawahare on 26/01/20.
//  Copyright © 2020 MyOrganization. All rights reserved.
//

import XCTest
@testable import MusicRover
class TracksTests: XCTestCase, DataParser {

    func testExampleArtistParsing() {
        guard let data = FileManager.readJson(forResource: "Tracks",
                                              bundle: Bundle(for: ArtistTests.self))  else {
                                                XCTAssert(false, "Can't get data from sample.json")
                                                return
        }
        let result: Result<RawAPIResponse<Track>, ErrorResult> = parse(data: data)
        switch result {
        case .success(let response):
            let artists = response.data!
            XCTAssertEqual(artists.count,
                           15,
                           "Parsing error or Tracks content")
            let artist = artists.first!
            XCTAssertEqual(artist.id,
                           597330992,
                           "Expected 597330992")
        case .failure:
            XCTAssert(false, "testExampleArtistParsing Parser Error")
        }
    }
}
