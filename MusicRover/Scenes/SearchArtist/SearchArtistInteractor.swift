//
//  SearchArtistInteractor.swift
//  MusicRover
//
//  Created by Dipak V. Vyawahare on 25/01/20.
//  Copyright (c) 2020 Globant Inc. All rights reserved.
//

import UIKit

class SearchArtistDataStore {
    //    var name: String = ""
}

class SearchArtistInteractor {
    var output: SearchArtistInteractorPresenterInterface?
    lazy var dataStore = SearchArtistDataStore()
    lazy var worker: SearchArtistWorker = SearchArtistWorker()
}

extension SearchArtistInteractor: SearchArtistViewControllerInteractorInterface {
    func searchArtist(request: SearchArtist.Request) {
        
    }
}
