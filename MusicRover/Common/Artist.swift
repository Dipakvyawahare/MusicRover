//
//  Artist.swift
//  MusicRover
//
//  Created by Dipak V. Vyawahare on 25/01/20.
//  Copyright © 2020 MyOrganization. All rights reserved.
//

import Foundation

struct Artist: Decodable {
    let id: Int
    let name: String
    let link, picture: String?
    let pictureSmall, pictureMedium, pictureBig, pictureXl: String?
    let nbAlbum, nbFan: Int?
    let radio: Bool?
    let tracklist: String
    let type: String
}
