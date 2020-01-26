//
//  RawServerResponse.swift
//  MusicRover
//
//  Created by Dipak V. Vyawahare on 25/01/20.
//  Copyright © 2020 MyOrganization. All rights reserved.
//

class RawAPIResponse<T: Decodable>: Decodable {
    let data: [T]?
    let total: Int
    let next: String?
}
