//
//  AlbumDetailsViewController.swift
//  MusicRover
//
//  Created by Dipak V. Vyawahare on 29/01/20.
//  Copyright (c) 2020 Globant Inc. All rights reserved.
//

import UIKit

class AlbumDetailsViewController: UIViewController {
    var output: AlbumDetailsViewControllerInteractorInterface?
    var router: AlbumDetailsRouter = AlbumDetailsRouter()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupVIPCycle()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupVIPCycle()
    }
    
    private func setupVIPCycle() {
        let presenter = AlbumDetailsPresenter()
        presenter.output = self
        let interactor = AlbumDetailsInteractor()
        interactor.output = presenter
        self.output = interactor
        router.viewController = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension AlbumDetailsViewController: AlbumDetailsPresenterViewControllerInterface {
    func displayTracks(viewModel: AlbumDetails.ViewModel) {
        
    }
    
    func displayError(error: ErrorResult) {
        
    }
}
