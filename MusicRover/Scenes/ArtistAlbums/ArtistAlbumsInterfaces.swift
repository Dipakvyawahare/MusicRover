//
//  ArtistAlbumsInterfaces.swift
//  MusicRover
//
//  Created by Dipak V. Vyawahare on 27/01/20.
//  Copyright (c) 2020 MyOrganization Inc. All rights reserved.
//

protocol ArtistAlbumsViewControllerInteractorInterface {
    func fetchAlbums(request: SearchArtist.ViewModel.RowDataSource)
    func loadMoreAlbums()
}

protocol ArtistAlbumsInteractorPresenterInterface {
    func presentAlbums(response: ArtistAlbums.Response)
}

protocol ArtistAlbumsPresenterViewControllerInterface: class {
    func displayAlbums(viewModel: ArtistAlbums.ViewModel)
    func displayError(error: ErrorResult)
}
