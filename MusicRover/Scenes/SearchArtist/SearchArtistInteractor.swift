//
//  SearchArtistInteractor.swift
//  MusicRover
//
//  Created by Dipak V. Vyawahare on 25/01/20.
//  Copyright (c) 2020 MyOrganization Inc. All rights reserved.
//

import UIKit

class SearchArtistInteractor {
    var output: SearchArtistInteractorPresenterInterface?
    lazy var worker: SearchArtistWorker = SearchArtistWorker()
    weak var lastNetworkRequest: URLSessionDataTask?
    var cachedResult: PagingDataStore<Artist>?
}

extension SearchArtistInteractor: SearchArtistViewControllerInteractorInterface {
    func searchArtist(request: SearchArtist.Request) {
        lastNetworkRequest?.cancel()
        lastNetworkRequest = worker.searchArtist(inputString: request.inputString) { [weak self] (result) in
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
        output?.presentArtistSearchResult(response: SearchArtist.Response(result: .success(artists),
                                                                          shouldAllowLoadMore: shouldAllowLoadMore))
    }
    
    func preesntFailure(error: ErrorResult) {
        output?.presentArtistSearchResult(response: SearchArtist.Response(result: .failure(error),
                                                                          shouldAllowLoadMore: false))
    }
    
    func loadMoreArtist(request: SearchArtist.Request) {
        lastNetworkRequest?.cancel()
        let index = cachedResult?.index ?? 0
        lastNetworkRequest = worker.searchArtist(inputString: request.inputString,
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
