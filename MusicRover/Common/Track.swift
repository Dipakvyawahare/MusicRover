//
//  Track.swift
//  MusicRover
//
//  Created by Dipak V. Vyawahare on 29/01/20.
//  Copyright © 2020 MyOrganization. All rights reserved.
//

import Foundation

struct Track: Decodable {
    let id: Int
    let readable: Bool
    let title, titleShort, titleVersion, isrc: String
    let link: String?
    let duration, trackPosition, diskNumber, rank: Int
    let explicitLyrics: Bool
    let explicitContentLyrics, explicitContentCover: Int
    let preview: String
    let artist: Artist
    let type: String
}
