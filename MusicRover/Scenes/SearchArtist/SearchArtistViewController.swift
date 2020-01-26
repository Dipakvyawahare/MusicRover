//
//  SearchArtistViewController.swift
//  MusicRover
//
//  Created by Dipak V. Vyawahare on 25/01/20.
//  Copyright (c) 2020 MyOrganization Inc. All rights reserved.
//

import UIKit

class SearchArtistViewController: UIViewController {
    var output: SearchArtistViewControllerInteractorInterface?
    var router: SearchArtistRouter = SearchArtistRouter()
    
    lazy var tableViewDataSource = SearchArtistsTableViewDataSource()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
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
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.dataSource = tableViewDataSource
//        tableView.delegate = tableViewDataSource
    }
    
    func searchArtist(seed: String) {
        let request = SearchArtist.Request(inputString: seed)
        output?.searchArtist(request: request)
    }
    
}

extension SearchArtistViewController: SearchArtistPresenterViewControllerInterface {
    func displayError(message: String) {
        
    }
    
    func displayArtists(viewModel: SearchArtist.ViewModel) {
        tableViewDataSource.artists = viewModel.artists
        tableView.reloadData()
    }
}

extension SearchArtistViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}

extension SearchArtistViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar,
                   textDidChange searchText: String) {
        searchArtist(seed: searchText)
    }
}
