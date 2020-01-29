//
//  AlbumDetailsWorker.swift
//  MusicRover
//
//  Created by Dipak V. Vyawahare on 29/01/20.
//  Copyright (c) 2020 Globant Inc. All rights reserved.
//

import UIKit

class AlbumDetailsWorker {
    typealias Handler = (Result<RawAPIResponse<Track>, ErrorResult>) -> Void
    func fetchTracks(albumId: Int,
                     completion: @escaping (Handler)) -> URLSessionDataTask? {
        let task = RequestService.shared.fetchData(for: "album/\(albumId)/tracks",
        queryParmas: [:]) { [weak self] (result) in
            switch result {
            case .success(let data) :
                if let parsed: Result<RawAPIResponse<Track>,
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
extension AlbumDetailsWorker: DataParser {}

