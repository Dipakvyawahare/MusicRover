//
//  SearchArtistRouter.swift
//  MusicRover
//
//  Created by Dipak V. Vyawahare on 25/01/20.
//  Copyright (c) 2020 MyOrganization Inc. All rights reserved.
//

import UIKit

protocol SearchArtistRouterInput {
    func navigateToArtistAlbums(row: SearchArtist.ViewModel.RowDataSource)
}

class SearchArtistRouter: SearchArtistRouterInput {
    weak var viewController: SearchArtistViewController?
    
    func navigateToArtistAlbums(row: SearchArtist.ViewModel.RowDataSource) {
        let sbrd = viewController?.storyboard
        if let dvc = sbrd?.instantiateViewController(
            withIdentifier: "ArtistAlbumsViewController") as? ArtistAlbumsViewController {
            viewController?.show(dvc, sender: nil)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                dvc.output?.fetchAlbums(request: row)
            }
        }
    }
}
