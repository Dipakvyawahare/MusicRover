//
//  SearchArtistPresenter.swift
//  MusicRover
//
//  Created by Dipak V. Vyawahare on 25/01/20.
//  Copyright (c) 2020 MyOrganization Inc. All rights reserved.
//

class SearchArtistPresenter: SearchArtistInteractorPresenterInterface {
    weak var output: SearchArtistPresenterViewControllerInterface?
    
    func presentArtistSearchResult(response: SearchArtist.Response) {
        switch response.result {
        case .success(let artists):
            var rows = [SearchArtist.ViewModel.RowDataSource]()
            for item in artists {
                let descri = "Fans- \(item.nbFan ?? 0)\nAlbums- \(item.nbAlbum ?? 0)"
                rows.append(SearchArtist.ViewModel.RowDataSource(id: item.id,
                                                                 image: item.pictureMedium ?? "",
                                                                 name: item.name,
                                                                 description: descri))
            }
            let viewModel = SearchArtist.ViewModel(artists: rows,
                                                   shouldAllowLoadMore: response.shouldAllowLoadMore)
            output?.displayArtists(viewModel: viewModel)
        case .failure(let error):
            output?.displayError(error: error)
        }
    }
}
