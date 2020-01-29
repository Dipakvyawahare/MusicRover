//
//  ArtistAlbumsInteractor.swift
//  MusicRover
//
//  Created by Dipak V. Vyawahare on 27/01/20.
//  Copyright (c) 2020 MyOrganization Inc. All rights reserved.
//

import UIKit

class ArtistAlbumsInteractor {
    var output: ArtistAlbumsInteractorPresenterInterface?
    weak var lastNetworkRequest: URLSessionDataTask?
    var cachedResult: PagingDataStore<Album>?
    lazy var worker: ArtistAlbumsWorker = ArtistAlbumsWorker()
    var artist: SearchArtist.ViewModel.RowDataSource!
}

extension ArtistAlbumsInteractor: ArtistAlbumsViewControllerInteractorInterface {
    func fetchAlbums(request: SearchArtist.ViewModel.RowDataSource) {
        artist = request
        lastNetworkRequest?.cancel()
        lastNetworkRequest = worker.fetchArtistAlbums(artistid: request.id) { [weak self] (result) in
            switch result {
            case .success(let poi):
                self?.cachedResult = PagingDataStore(total: poi.total)
                if let objects = poi.data {
                    self?.cachedResult?.appendObjects(objects: objects)
                    self?.presentResult()
                }
            case .failure(let error):
                self?.preesntFailure(error: error)
            }
        }
    }
    
    func presentResult() {
        let artists = cachedResult?.objects ?? []
        let shouldAllowLoadMore = cachedResult?.shouldLoadMore ?? false
        output?.presentAlbums(response: ArtistAlbums.Response(artistName: artist.name,
                                                              result: .success(artists),
                                                              shouldAllowLoadMore: shouldAllowLoadMore))
    }
    
    func preesntFailure(error: ErrorResult) {
        output?.presentAlbums(response: ArtistAlbums.Response(artistName: artist.name,
                                                              result: .failure(error),
                                                              shouldAllowLoadMore: false))
    }
    
    func loadMoreAlbums() {
        lastNetworkRequest?.cancel()
        let index = cachedResult?.index ?? 0
        lastNetworkRequest = worker.fetchArtistAlbums(artistid: artist.id,
                                                       index: index) { [weak self] (result) in
                                                        switch result {
                                                        case .success(let poi):
                                                            if let objects = poi.data {
                                                                self?.cachedResult?.appendObjects(objects: objects)
                                                                self?.presentResult()
                                                            }
                                                        case .failure(let error):
                                                            self?.preesntFailure(error: error)
                                                        }
        }
    }
}
