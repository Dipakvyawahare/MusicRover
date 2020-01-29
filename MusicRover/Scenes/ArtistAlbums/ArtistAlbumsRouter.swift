//
//  ArtistAlbumsRouter.swift
//  MusicRover
//
//  Created by Dipak V. Vyawahare on 27/01/20.
//  Copyright (c) 2020 Globant Inc. All rights reserved.
//

import UIKit

protocol ArtistAlbumsRouterInput {
    func navigateToDetails(row: ArtistAlbums.ViewModel.RowDataSource)
}

class ArtistAlbumsRouter: ArtistAlbumsRouterInput {
    weak var viewController: ArtistAlbumsViewController?
    
    func navigateToDetails(row: ArtistAlbums.ViewModel.RowDataSource) {
        let sbrd = viewController?.storyboard
        if let dvc = sbrd?.instantiateViewController(
            withIdentifier: "AlbumDetailsViewController") as? AlbumDetailsViewController {
            viewController?.show(dvc, sender: nil)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                dvc.output?.fetchTracks(request: AlbumDetails.Album(id: row.id,
                                                                      name: row.album,
                                                                      image: row.image))
            }
        }
    }
}
