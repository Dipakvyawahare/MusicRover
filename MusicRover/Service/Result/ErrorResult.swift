//
//  ErrorResult.swift
//  MusicRover
//
//  Created by Dipak V. Vyawahare on 25/01/20.
//  Copyright © 2020 MyOrganization. All rights reserved.
//

import Foundation
@objc enum ErrorCase: Int {
    case network
    case parser
    case custom
}

@objcMembers
class ErrorResult: NSObject, Error {
    var type: ErrorCase
    var message = ""
    init(_ type: ErrorCase, _ message: String) {
        self.type = type
        self.message = message
    }
}
