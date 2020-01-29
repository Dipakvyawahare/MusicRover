//
//  AlbumDetailsInteractor.swift
//  MusicRover
//
//  Created by Dipak V. Vyawahare on 29/01/20.
//  Copyright (c) 2020 MyOrganization Inc. All rights reserved.
//

import UIKit

class AlbumDetailsInteractor {
    var output: AlbumDetailsInteractorPresenterInterface?
    lazy var worker: AlbumDetailsWorker = AlbumDetailsWorker()
    var album: AlbumDetails.Album!
    weak var lastNetworkRequest: URLSessionDataTask?
}

extension AlbumDetailsInteractor: AlbumDetailsViewControllerInteractorInterface {
    func fetchTracks(request: AlbumDetails.Album) {
        album = request
        lastNetworkRequest?.cancel()
        lastNetworkRequest = worker.fetchTracks(albumId: album.id) { [weak self] (result) in
            switch result {
            case .success(let poi):
                self?.presentResult(tracks: poi.data ?? [])
            case .failure(let error):
                self?.preesntFailure(error: error)
            }
        }
    }
    
    func presentResult(tracks: [Track]) {
        output?.presentTracks(response: AlbumDetails.Response(album: album,
                                                              result: .success(tracks)))
    }
    
    func preesntFailure(error: ErrorResult) {
        output?.presentTracks(response: AlbumDetails.Response(album: album,
                                                              result: .failure(error)))
    }
    
    func reload() {
        fetchTracks(request: album)
    }
}
