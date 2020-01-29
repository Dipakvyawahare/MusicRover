//
//  ArtistAlbumsWorker.swift
//  MusicRover
//
//  Created by Dipak V. Vyawahare on 27/01/20.
//  Copyright (c) 2020 MyOrganization Inc. All rights reserved.
//

import UIKit

class ArtistAlbumsWorker {
    typealias Handler = (Result<RawAPIResponse<Album>, ErrorResult>) -> Void
    lazy var service: RequestServiceProtocol = RequestService.shared
//    lazy var service: RequestServiceProtocol = MockAPIService.shared
    func fetchArtistAlbums(artistid: Int,
                           index: Int = 0,
                           completion: @escaping (Handler)) -> URLSessionDataTask? {
        
       let task = service.fetchData(for: "artist/\(artistid)/albums",
        queryParmas: ["index": String(index)]) { [weak self] (result) in
            switch result {
            case .success(let data) :
                if let parsed: Result<RawAPIResponse<Album>,
                    ErrorResult> = self?.parse(data: data) {
                    switch parsed {
                    case .success(let poi):
                        completion(.success(poi))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            case .failure(let error) :
                completion(.failure(error))
            }
        }
        return task
    }
}

extension ArtistAlbumsWorker: DataParser {}

// FIXME: Here's something you need to fix
class MockAPIService: RequestServiceProtocol {
    static let shared = MockAPIService()
    func fetchData(for path: String, queryParmas: [String: String],
                   completion: @escaping ((Result<Data, ErrorResult>) -> Void)) -> URLSessionDataTask? {
        guard let data = FileManager.readJson(forResource: "Albums",
                                              bundle: Bundle(for: MockAPIService.self))  else {
                                                return nil
        }
        completion(.success(data))
        return nil
    }
}
