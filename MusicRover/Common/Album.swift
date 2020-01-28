//
//  Album.swift
//  MusicRover
//
//  Created by Dipak V. Vyawahare on 28/01/20.
//  Copyright © 2020 MyOrganization. All rights reserved.
//

import Foundation

struct Album: Decodable {
    let id: Int
    let title: String
    let link, cover: String
    let coverSmall, coverMedium, coverBig, coverXl: String
    let genreId, fans: Int
    let releaseDate, recordType: String
    let tracklist: String
    let explicitLyrics: Bool
    let type: String
}
