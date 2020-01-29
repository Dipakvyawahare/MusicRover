//
//  AlbumDetailsWorkerTests.swift
//  MusicRover
//
//  Created by Dipak V. Vyawahare on 29/01/20.
//  Copyright (c) 2020 MyOrganization Inc. All rights reserved.
//

import XCTest
@testable import MusicRover

class AlbumDetailsWorkerTests: XCTestCase {
    var sut: AlbumDetailsWorker!
    let workerOutputSpy = ServiceOutputSpy()
    
    override func setUp() {
        super.setUp()
        configure()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func configure() {
        sut = AlbumDetailsWorker()
        sut.service = workerOutputSpy
    }

    func testFetch() {
        workerOutputSpy.performFailedTest = false
        _ = sut.fetchTracks(albumId: 1, completion: { (result) in
            switch result {
            case .failure:
                XCTAssert(false, "Expected valid testFetch() data")
            default:
                break
            }
        })
    }
    
    func testFailedFetch() {
        workerOutputSpy.performFailedTest = true
        _ = sut.fetchTracks(albumId: 1, completion: { (result) in
            switch result {
            case .success:
                XCTAssert(false, "Expected failure testFailedFetch()")
            default:
                break
            }
        })
    }
    
    class ServiceOutputSpy: RequestServiceProtocol {
        var performFailedTest = false
        func fetchData(for path: String,
                       queryParmas: [String: String],
                       completion: @escaping ((Result<Data, ErrorResult>) -> Void)) -> URLSessionDataTask? {
            if performFailedTest == false {
                guard let data = FileManager.readJson(forResource: "Tracks",
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
