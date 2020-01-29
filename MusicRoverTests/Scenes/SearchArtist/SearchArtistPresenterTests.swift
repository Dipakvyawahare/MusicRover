//
//  SearchArtistPresenterTests.swift
//  MusicRover
//
//  Created by Dipak V. Vyawahare on 29/01/20.
//  Copyright (c) 2020 MyOrganization Inc. All rights reserved.
//

import XCTest
@testable import MusicRover

class SearchArtistPresenterTests: XCTestCase {
    var sut: SearchArtistPresenter!
    let presenterOutputSpy = SearchArtistPresenterOutputSpy()
    
    override func setUp() {
        super.setUp()
        configure()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func configure() {
        sut = SearchArtistPresenter()
        sut.output = presenterOutputSpy
    }
    
    func testSearchArtist() {
        sut.presentArtistSearchResult(response: SearchArtist.Response(result: .failure(.network(string: "")),
                                                                      shouldAllowLoadMore: true))
        XCTAssert(presenterOutputSpy.errorShown, "presentArtistSearchResult() should have been called")
    }
    
    class SearchArtistPresenterOutputSpy: SearchArtistPresenterViewControllerInterface {
        func displayError(error: ErrorResult) {
            errorShown = true
        }
        
        func displayArtists(viewModel: SearchArtist.ViewModel) {
            errorShown = true
        }
        var errorShown = false
    }
}
