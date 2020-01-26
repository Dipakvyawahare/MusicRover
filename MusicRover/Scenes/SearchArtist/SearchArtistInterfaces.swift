//
//  SearchArtistInterfaces.swift
//  MusicRover
//
//  Created by Dipak V. Vyawahare on 25/01/20.
//  Copyright (c) 2020 Globant Inc. All rights reserved.
//

protocol SearchArtistViewControllerInteractorInterface {
    func searchArtist(request: SearchArtist.Request)
}

protocol SearchArtistInteractorPresenterInterface {
    func presentArtistSearchResult(response: SearchArtist.Response)
}

protocol SearchArtistPresenterViewControllerInterface: class {
    func displayArtists(viewModel: SearchArtist.ViewModel)
}
