//
//  SearchArtistInteractorTests.swift
//  MusicRover
//
//  Created by Dipak V. Vyawahare on 29/01/20.
//  Copyright (c) 2020 MyOrganization Inc. All rights reserved.
//

import XCTest
@testable import MusicRover

class SearchArtistInteractorTests: XCTestCase {
    var sut: SearchArtistInteractor!
    
    let interactorOutputSpy = SearchArtistInteractorOutputSpy()
    let workerSpy = SearchArtistWorkerSpy()
    
    override func setUp() {
        super.setUp()
        configure()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func configure() {
        sut = SearchArtistInteractor()
        sut.output = interactorOutputSpy
        sut.worker = workerSpy
    }
    
    func testSearchArtist() {
        workerSpy.performFailedTest = false
        sut.searchArtist(request: SearchArtist.Request(inputString: ""))
        XCTAssert(interactorOutputSpy.fetched, "presentArtistSearchResult() should have been called")
        XCTAssert(workerSpy.fetchSearchArtistCalled, "searchArtist() should have been called")
    }
    
    func testDisplayError() {
        workerSpy.performFailedTest = true
        sut.searchArtist(request: SearchArtist.Request(inputString: ""))
        XCTAssert(workerSpy.fetchSearchArtistCalled, "searchArtist() should have been called")
    }
    
    class SearchArtistInteractorOutputSpy: SearchArtistInteractorPresenterInterface {
        func presentArtistSearchResult(response: SearchArtist.Response) {
            fetched = true
        }
        var fetched = false
    }
    
    class SearchArtistWorkerSpy: SearchArtistWorker {
        var fetchSearchArtistCalled = false
        var performFailedTest = false
        override func searchArtist(inputString: String,
                                   index: Int = 0,
                                   completion:
            @escaping (SearchArtistWorker.SearchWorkerHandler)) -> URLSessionDataTask? {
            fetchSearchArtistCalled = true
            if performFailedTest == false {
                guard let data = FileManager.readJson(forResource: "Sample",
                                                      bundle: Bundle(for: ArtistTests.self))  else {
                                                        XCTAssert(false, "Can't get data from sample.json")
                                                        return nil
                }
                let parsed: Result<RawAPIResponse<Artist>, ErrorResult> = self.parse(data: data)
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
