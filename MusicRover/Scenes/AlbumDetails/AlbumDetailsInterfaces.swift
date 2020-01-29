//
//  AlbumDetailsInterfaces.swift
//  MusicRover
//
//  Created by Dipak V. Vyawahare on 29/01/20.
//  Copyright (c) 2020 Globant Inc. All rights reserved.
//

protocol AlbumDetailsViewControllerInteractorInterface {
    func fetchTracks(request: AlbumDetails.Request)
}

protocol AlbumDetailsInteractorPresenterInterface {
    func presentTracks(response: AlbumDetails.Response)
}

protocol AlbumDetailsPresenterViewControllerInterface : class {
    func displayTracks(viewModel: AlbumDetails.ViewModel)
    func displayError(error: ErrorResult)
}
