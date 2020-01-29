//
//  AlbumDetailsPresenterTests.swift
//  MusicRover
//
//  Created by Dipak V. Vyawahare on 29/01/20.
//  Copyright (c) 2020 MyOrganization Inc. All rights reserved.
//

import XCTest
@testable import MusicRover

class AlbumDetailsPresenterTests: XCTestCase {
    var sut: AlbumDetailsPresenter!
    let presenterOutputSpy = AlbumDetailsPresenterOutputSpy()
    
    override func setUp() {
        super.setUp()
        configure()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func configure() {
        sut = AlbumDetailsPresenter()
        sut.output = presenterOutputSpy
    }
    
    func testAlbumDetails() {
        sut.presentTracks(response: AlbumDetails.Response(album: AlbumDetails.Album(id: 1, name: "", image: ""),
                                                          result: .failure(.custom(string: ""))))
        XCTAssert(presenterOutputSpy.errorShown, "presentArtistSearchResult() should have been called")
    }
    
    class AlbumDetailsPresenterOutputSpy: AlbumDetailsPresenterViewControllerInterface {
        func displayTracks(viewModel: AlbumDetails.ViewModel) {
            errorShown = true
        }
        
        func displayError(error: ErrorResult) {
            errorShown = true
        }
        var errorShown = false
    }
}
