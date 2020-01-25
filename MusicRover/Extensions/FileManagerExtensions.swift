//
//  FileManagerExtensions.swift
//  MusicRover
//
//  Created by Dipak V. Vyawahare on 25/01/20.
//  Copyright © 2020 MyOrganization. All rights reserved.
//

import Foundation

extension FileManager {
    
    static func readJson(forResource fileName: String,
                         bundle: Bundle? = .main) -> Data? {
        if let path = bundle?.path(forResource: fileName,
                                   ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path),
                                    options: .mappedIfSafe)
                return data
            } catch {
                // handle error
            }
        }
        
        return nil
    }
}
