//
//  ArtistAlbumsRouter.swift
//  MusicRover
//
//  Created by Dipak V. Vyawahare on 27/01/20.
//  Copyright (c) 2020 Globant Inc. All rights reserved.
//

import UIKit

protocol ArtistAlbumsRouterInput {
    func navigateToSomewhere()
}

class ArtistAlbumsRouter: ArtistAlbumsRouterInput {
    weak var viewController: ArtistAlbumsViewController?
    
    func navigateToSomewhere() {
        //viewController.performSegueWithIdentifier("ShowSomewhereScene", sender: nil)
    }
    
    func passDataToNextScene(segue: UIStoryboardSegue) {
        //if segue.identifier == "ShowSomewhereScene" {
        //passDataToSomewhereScene(segue: segue)
        //}
    }
    
    func passDataToSomewhereScene(segue: UIStoryboardSegue) {
        // Pass data to segue.destination from here, take reference from AViewController
        // If, later segue.destination needs to send data back to AViewController, define protocol (delegate) in segue.destination
        //and implement in AViewController.
    }
}
