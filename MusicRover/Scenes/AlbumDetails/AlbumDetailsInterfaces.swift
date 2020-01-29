//
//  AlbumDetailsInterfaces.swift
//  MusicRover
//
//  Created by Dipak V. Vyawahare on 29/01/20.
//  Copyright (c) 2020 MyOrganization Inc. All rights reserved.
//

protocol AlbumDetailsViewControllerInteractorInterface {
    func fetchTracks(request: AlbumDetails.Album)
    func reload()
}

protocol AlbumDetailsInteractorPresenterInterface {
    func presentTracks(response: AlbumDetails.Response)
}

protocol AlbumDetailsPresenterViewControllerInterface: class {
    func displayTracks(viewModel: AlbumDetails.ViewModel)
    func displayError(error: ErrorResult)
}
