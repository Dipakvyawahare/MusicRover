//
//  SearchArtistWorker.swift
//  MusicRover
//
//  Created by Dipak V. Vyawahare on 25/01/20.
//  Copyright (c) 2020 Globant Inc. All rights reserved.
//

import UIKit

class SearchArtistWorker {
    func searchArtist(inputString: String,
                      completion: @escaping ((Result<[Artist], ErrorResult>) -> Void)) -> URLSessionDataTask? {
        RequestService.shared.fetchData(for: "search/artist",
                                        queryParmas: ["q": inputString]) { [weak self] (result) in
                                            switch result {
                                            case .success(let data) :
                                                if let parsed: Result<RawAPIResponse<Artist>,
                                                    ErrorResult> = self?.parse(data: data) {
                                                    switch parsed {
                                                    case .success(let poi):
                                                        completion(.success(poi.data ?? []))
                                                    case .failure(let error):
                                                        completion(.failure(error))
                                                    }
                                                }
                                            case .failure(let error) :
                                                print(error)
                                            }
        }
    }
}

extension SearchArtistWorker: DataParser {}
