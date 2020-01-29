//
//  AlbumDetailsInteractor.swift
//  MusicRover
//
//  Created by Dipak V. Vyawahare on 29/01/20.
//  Copyright (c) 2020 Globant Inc. All rights reserved.
//

import UIKit

class AlbumDetailsInteractor {
    var output: AlbumDetailsInteractorPresenterInterface?
    lazy var worker: AlbumDetailsWorker = AlbumDetailsWorker()
    var album: AlbumDetails.Request!
}

extension AlbumDetailsInteractor: AlbumDetailsViewControllerInteractorInterface {
    func fetchTracks(request: AlbumDetails.Request) {
        album = request
    }
}
