//
//  SearchArtistRouter.swift
//  MusicRover
//
//  Created by Dipak V. Vyawahare on 25/01/20.
//  Copyright (c) 2020 Globant Inc. All rights reserved.
//

import UIKit

protocol SearchArtistRouterInput {
    func navigateToSomewhere()
}

class SearchArtistRouter: SearchArtistRouterInput {
    weak var viewController: SearchArtistViewController?
    
    func navigateToSomewhere() {
        //viewController.performSegueWithIdentifier("ShowSomewhereScene", sender: nil)
    }
}
