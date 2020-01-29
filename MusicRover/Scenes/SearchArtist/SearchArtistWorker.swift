//
//  SearchArtistWorker.swift
//  MusicRover
//
//  Created by Dipak V. Vyawahare on 25/01/20.
//  Copyright (c) 2020 MyOrganization Inc. All rights reserved.
//

import UIKit

class SearchArtistWorker {
    lazy var service: RequestServiceProtocol = RequestService.shared
    typealias SearchWorkerHandler = (Result<RawAPIResponse<Artist>, ErrorResult>) -> Void
    func searchArtist(inputString: String,
                      index: Int = 0,
                      completion: @escaping (SearchWorkerHandler)) -> URLSessionDataTask? {
        let task = service.fetchData(for: "search/artist",
                                                   queryParmas: ["q": inputString,
                                                                 "index": String(index)]) { [weak self] (result) in
                                                                    switch result {
                                                                    case .success(let data) :
                                                                        if let parsed: Result<RawAPIResponse<Artist>,
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

extension SearchArtistWorker: DataParser {}
