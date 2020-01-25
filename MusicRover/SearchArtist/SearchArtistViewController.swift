//
//  SearchArtistViewController.swift
//  MusicRover
//
//  Created by Dipak V. Vyawahare on 25/01/20.
//  Copyright (c) 2020 Globant Inc. All rights reserved.
//

import UIKit

class SearchArtistViewController: UIViewController {
    var output: SearchArtistViewControllerInteractorInterface?
    var router: SearchArtistRouter = SearchArtistRouter()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupVIPCycle()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupVIPCycle()
    }
    
    private func setupVIPCycle() {
        let presenter = SearchArtistPresenter()
        presenter.output = self
        let interactor = SearchArtistInteractor()
        interactor.output = presenter
        self.output = interactor
        router.viewController = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchArtist()
    }
    
    func searchArtist() {
        let request = SearchArtist.Request(inputString: "My Input String")
        output?.searchArtist(request: request)
    }
}

extension SearchArtistViewController: SearchArtistPresenterViewControllerInterface {
    func displayArtists(viewModel: SearchArtist.ViewModel) {
        print(viewModel.formattedString)
    }
}

extension SearchArtistViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}
