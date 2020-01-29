//
//  AlbumDetailsInteractorTests.swift
//  MusicRover
//
//  Created by Dipak V. Vyawahare on 29/01/20.
//  Copyright (c) 2020 MyOrganization Inc. All rights reserved.
//

import XCTest
@testable import MusicRover

class AlbumDetailsInteractorTests: XCTestCase {
    var sut: AlbumDetailsInteractor!
    
    let interactorOutputSpy = AlbumDetailsInteractorOutputSpy()
    let workerSpy = AlbumDetailsWorkerSpy()
    
    override func setUp() {
        super.setUp()
        configure()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func configure() {
        sut = AlbumDetailsInteractor()
        sut.output = interactorOutputSpy
        sut.worker = workerSpy
    }
    
    func testAlbumDetails() {
        workerSpy.performFailedTest = false
        sut.fetchTracks(request: AlbumDetails.Album(id: 1, name: "", image: ""))
        XCTAssert(interactorOutputSpy.fetched, "presentTracks() should have been called")
        XCTAssert(workerSpy.fetchAlbumDetailsCalled, "fetchTracks() should have been called")
    }
    
    func testDisplayError() {
        workerSpy.performFailedTest = true
        sut.fetchTracks(request: AlbumDetails.Album(id: 1, name: "", image: ""))
        XCTAssert(workerSpy.fetchAlbumDetailsCalled, "fetchTracks() should have been called")
    }
    
    class AlbumDetailsInteractorOutputSpy: AlbumDetailsInteractorPresenterInterface {
        func presentTracks(response: AlbumDetails.Response) {
            fetched = true
        }
        var fetched = false
    }
    
    class AlbumDetailsWorkerSpy: AlbumDetailsWorker {
        var fetchAlbumDetailsCalled = false
        var performFailedTest = false
        override func fetchTracks(albumId: Int,
                                  completion: @escaping (AlbumDetailsWorker.Handler)) -> URLSessionDataTask? {
            fetchAlbumDetailsCalled = true
            if performFailedTest == false {
                guard let data = FileManager.readJson(forResource: "Tracks",
                                                      bundle: Bundle(for: ArtistTests.self))  else {
                                                        XCTAssert(false, "Can't get data from sample.json")
                                                        return nil
                }
                let parsed: Result<RawAPIResponse<Track>, ErrorResult> = self.parse(data: data)
                    switch parsed {
                    case .success(let poi):
                        completion(.success(poi))
                    default:
                        break
                    }
                } else {
                    completion(.failure(.network(string: "")))
                }
            return nil
            }
        }
}
