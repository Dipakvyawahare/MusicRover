//
//  ArtistAlbumsPresenter.swift
//  MusicRover
//
//  Created by Dipak V. Vyawahare on 27/01/20.
//  Copyright (c) 2020 MyOrganization Inc. All rights reserved.
//

class ArtistAlbumsPresenter: ArtistAlbumsInteractorPresenterInterface {
    weak var output: ArtistAlbumsPresenterViewControllerInterface?
    
    func presentAlbums(response: ArtistAlbums.Response) {
        let artist = "\(response.artistName)'s Albums"
        switch response.result {
        case .success(let objects):
            var rows = [ArtistAlbums.ViewModel.RowDataSource]()
            for item in objects {
                rows.append(ArtistAlbums.ViewModel.RowDataSource(id: item.id,
                                                                 image: item.coverMedium,
                                                                 album: item.title))
            }
            let viewModel = ArtistAlbums.ViewModel(albums: rows,
                                                   artistName: artist,
                                                   shouldAllowLoadMore: response.shouldAllowLoadMore)
            output?.displayAlbums(viewModel: viewModel)
        case .failure(let error):
            output?.displayError(error: error)
        }
    }
}
