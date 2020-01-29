//
//  AlbumDetailsModels.swift
//  MusicRover
//
//  Created by Dipak V. Vyawahare on 29/01/20.
//  Copyright (c) 2020 Globant Inc. All rights reserved.
//

struct AlbumDetails {
    struct Request {
        let albumId: Int
    }
    struct Response {
        let outputString:String
    }
    struct ViewModel {
        let formattedString:String
    }
}
