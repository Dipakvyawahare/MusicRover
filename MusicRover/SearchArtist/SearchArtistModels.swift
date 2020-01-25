//
//  SearchArtistModels.swift
//  MusicRover
//
//  Created by Dipak V. Vyawahare on 25/01/20.
//  Copyright (c) 2020 Globant Inc. All rights reserved.
//

struct SearchArtist {
    struct Request {
        let inputString: String
    }
    struct Response {
        let result: Result<Artist, ErrorResult>
    }
    struct ViewModel {
        let formattedString: String
    }
}
