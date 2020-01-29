//
//  SearchArtistWorkerTests.swift
//  MusicRover
//
//  Created by Dipak V. Vyawahare on 29/01/20.
//  Copyright (c) 2020 Globant Inc. All rights reserved.
//

import XCTest
@testable import MusicRover

class SearchArtistWorkerTests: XCTestCase {
    var sut: SearchArtistWorker!
    let workerOutputSpy = ServiceOutputSpy()
    
    override func setUp() {
        super.setUp()
        configure()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func configure() {
        sut = SearchArtistWorker()
        sut.service = workerOutputSpy
    }

    func testSearch() {
        workerOutputSpy.performFailedTest = false
        _ = sut.searchArtist(inputString: "") { (result) in
            switch result {
            case .failure:
                XCTAssert(false, "Expected valid testSearch() data")
            default:
                break
            }
        }
    }
    
    func testFailedSearch() {
        workerOutputSpy.performFailedTest = true
        _ = sut.searchArtist(inputString: "") { (result) in
            switch result {
            case .success:
                XCTAssert(false, "Expected failure testFailedSearch()")
            default:
                break
            }
        }
    }
    
    class ServiceOutputSpy: RequestServiceProtocol {
        var performFailedTest = false
        func fetchData(for path: String,
                       queryParmas: [String: String],
                       completion: @escaping ((Result<Data, ErrorResult>) -> Void)) -> URLSessionDataTask? {
            if performFailedTest == false {
                guard let data = FileManager.readJson(forResource: "Sample",
                                                      bundle: Bundle(for: ArtistTests.self))  else {
                                                        XCTAssert(false, "Can't get data from sample.json")
                                                        return nil
                }
                completion(.success(data))
            } else {
                completion(.failure(.network(string: "")))
            }
            return nil
        }
    }
}
