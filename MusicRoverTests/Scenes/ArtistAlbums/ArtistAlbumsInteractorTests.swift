//
//  ArtistAlbumsInteractorTests.swift
//  MusicRover
//
//  Created by Dipak V. Vyawahare on 29/01/20.
//  Copyright (c) 2020 MyOrganization Inc. All rights reserved.
//

import XCTest
@testable import MusicRover

class ArtistAlbumsInteractorTests: XCTestCase {
    var sut: ArtistAlbumsInteractor!
    
    let interactorOutputSpy = ArtistAlbumsInteractorOutputSpy()
    let workerSpy = ArtistAlbumsWorkerSpy()
    
    override func setUp() {
        super.setUp()
        configure()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func configure() {
        sut = ArtistAlbumsInteractor()
        sut.output = interactorOutputSpy
        sut.worker = workerSpy
    }
    
    func testArtistAlbums() {
        workerSpy.performFailedTest = false
        sut.fetchAlbums(request: SearchArtist.ViewModel.RowDataSource(id: 2, image: "", name: "", description: ""))
        XCTAssert(interactorOutputSpy.fetched, "presentAlbums() should have been called")
        XCTAssert(workerSpy.fetchArtistAlbumsCalled, "fetchArtistAlbums() should have been called")
    }
    
    func testDisplayError() {
        workerSpy.performFailedTest = true
        sut.fetchAlbums(request: SearchArtist.ViewModel.RowDataSource(id: 2, image: "", name: "", description: ""))
        XCTAssert(workerSpy.fetchArtistAlbumsCalled, "fetchArtistAlbums() should have been called")
    }
    
    class ArtistAlbumsInteractorOutputSpy: ArtistAlbumsInteractorPresenterInterface {
        func presentAlbums(response: ArtistAlbums.Response) {
            fetched = true
        }
        var fetched = false
    }
    
    class ArtistAlbumsWorkerSpy: ArtistAlbumsWorker {
        var fetchArtistAlbumsCalled = false
        var performFailedTest = false
        override func fetchArtistAlbums(artistid: Int,
                                        index: Int = 0,
                                        completion: @escaping (ArtistAlbumsWorker.Handler)) -> URLSessionDataTask? {
            fetchArtistAlbumsCalled = true
            if performFailedTest == false {
                guard let data = FileManager.readJson(forResource: "Albums",
                                                      bundle: Bundle(for: ArtistTests.self))  else {
                                                        XCTAssert(false, "Can't get data from sample.json")
                                                        return nil
                }
                let parsed: Result<RawAPIResponse<Album>, ErrorResult> = self.parse(data: data)
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
