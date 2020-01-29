//
//  AlbumDetailsModels.swift
//  MusicRover
//
//  Created by Dipak V. Vyawahare on 29/01/20.
//  Copyright (c) 2020 MyOrganization Inc. All rights reserved.
//

struct AlbumDetails {
    struct Album {
        let id: Int
        let name: String
        let image: String
    }
    struct Response {
        let album: Album
        let result: Result<[Track], ErrorResult>
    }
    struct ViewModel {
        struct RowDataSource {
            let id: Int
            let name: String
            let time: String
            let index: String
            let artist: String
            let preview: String
        }
        let album: Album
        let title: String
        let tracks: [RowDataSource]
    }
}
