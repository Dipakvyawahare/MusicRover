//
//  DataParser.swift
//  MusicRover
//
//  Created by Dipak V. Vyawahare on 25/01/20.
//  Copyright © 2020 MyOrganization. All rights reserved.
//

import UIKit

protocol DataParser {
    func parse<T: Decodable>(data: Data?) -> Result<T, ErrorResult>
}

extension DataParser {
    func parse<T: Decodable>(data: Data?) -> Result<T, ErrorResult> {
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            if let data = data {
                let model = try decoder.decode(T.self,
                                               from: data)
                return .success(model)
            } else {
                return .failure(ErrorResult(.parser, "No Json data"))
            }
            
        } catch _ {
            return .failure(ErrorResult(.parser, "Error while parsing json data"))
        }
    }
}
