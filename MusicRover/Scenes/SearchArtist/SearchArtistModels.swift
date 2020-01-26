//
//  SearchArtistModels.swift
//  MusicRover
//
//  Created by Dipak V. Vyawahare on 25/01/20.
//  Copyright (c) 2020 MyOrganization Inc. All rights reserved.
//

struct SearchArtist {
    struct Request {
        let inputString: String
    }
    struct Response {
        let result: Result<[Artist], ErrorResult>
        let shouldAllowLoadMore: Bool
    }
    struct ViewModel {
        struct RowDataSource {
            let image: String
            let name: String
            let description: String
        }
        let artists: [RowDataSource]
        let shouldAllowLoadMore: Bool
    }
}
