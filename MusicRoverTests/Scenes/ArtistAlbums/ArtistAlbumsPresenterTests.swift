//
//  ArtistAlbumsPresenterTests.swift
//  MusicRover
//
//  Created by Dipak V. Vyawahare on 29/01/20.
//  Copyright (c) 2020 MyOrganization Inc. All rights reserved.
//

import XCTest
@testable import MusicRover

class ArtistAlbumsPresenterTests: XCTestCase {
    var sut: ArtistAlbumsPresenter!
    let presenterOutputSpy = ArtistAlbumsPresenterOutputSpy()
    
    override func setUp() {
        super.setUp()
        configure()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func configure() {
        sut = ArtistAlbumsPresenter()
        sut.output = presenterOutputSpy
    }
    
    func testArtistAlbums() {
        sut.presentAlbums(response: ArtistAlbums.Response(artistName: "",
                                                          result: .failure(.network(string: "")),
                                                          shouldAllowLoadMore: true))
        XCTAssert(presenterOutputSpy.errorShown, "presentArtistSearchResult() should have been called")
    }
    
    class ArtistAlbumsPresenterOutputSpy: ArtistAlbumsPresenterViewControllerInterface {
        func displayAlbums(viewModel: ArtistAlbums.ViewModel) {
            errorShown = true
        }
        
        func displayError(error: ErrorResult) {
            errorShown = true
        }
        var errorShown = false
    }
}
