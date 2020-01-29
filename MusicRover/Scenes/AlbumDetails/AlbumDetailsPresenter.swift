//
//  AlbumDetailsPresenter.swift
//  MusicRover
//
//  Created by Dipak V. Vyawahare on 29/01/20.
//  Copyright (c) 2020 Globant Inc. All rights reserved.
//

class AlbumDetailsPresenter: AlbumDetailsInteractorPresenterInterface {
    weak var output: AlbumDetailsPresenterViewControllerInterface?
    
    func presentTracks(response: AlbumDetails.Response) {
        let title = "\(response.album.name)'s Tracks"
        switch response.result {
        case .success(let objects):
            var rows = [AlbumDetails.ViewModel.RowDataSource]()
            for item in objects {
                rows.append(AlbumDetails.ViewModel.RowDataSource(id: item.id,
                                                                 name: item.title,
                                                                 time: getDuarationString(duration: item.duration),
                                                                 index: "\(item.trackPosition).",
                                                                 artist: item.artist.name,
                                                                 preview: item.preview))
            }
            let viewModel = AlbumDetails.ViewModel(album: response.album,
                                                   title: title,
                                                   tracks: rows)
            output?.displayTracks(viewModel: viewModel)
        case .failure(let error):
            output?.displayError(error: error)
        }
    }
    
    private func getDuarationString(duration: Int) -> String {
        let sec = duration % 60
        let min = duration / 60
        return "\(min):\(sec)"
    }
}
