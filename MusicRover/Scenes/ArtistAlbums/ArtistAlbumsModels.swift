//
//  ArtistAlbumsModels.swift
//  MusicRover
//
//  Created by Dipak V. Vyawahare on 27/01/20.
//  Copyright (c) 2020 Globant Inc. All rights reserved.
//

struct ArtistAlbums {
    struct Request {
        let inputString:String
    }
    struct Response {
        let artistName: String
        let result: Result<[Album], ErrorResult>
        let shouldAllowLoadMore: Bool
    }
    struct ViewModel {
        struct RowDataSource {
            let id: Int
            let image: String
            let album: String
        }
        let albums: [RowDataSource]
        let artistName: String
        let shouldAllowLoadMore: Bool
    }
}
