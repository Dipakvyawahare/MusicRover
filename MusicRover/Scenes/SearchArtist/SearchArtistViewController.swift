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
    var shouldLoadMoreObject = false
    
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
        tableView.delegate = self
    }
    
    func searchArtist(seed: String?, loadMore: Bool = false) {
        if let seed = seed, seed.count > 0 {
            let request = SearchArtist.Request(inputString: seed)
            if loadMore {
                output?.loadMoreArtist(request: request)
            } else {
                output?.searchArtist(request: request)
            }
        }
    }
}

extension SearchArtistViewController: SearchArtistPresenterViewControllerInterface, AppDisplayable {
    func displayError(error: ErrorResult) {
        let retryAction = UIAlertAction(title: "Retry", style: .default) { [weak self] _ in
            self?.searchArtist(seed: self?.searchBar.text)
        }
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        switch error {
        case .custom(let msg):
            self.display(title: "Alert", error: msg, actions: [retryAction])
        case .network(let msg):
            self.display(title: "Network", error: msg, actions: [retryAction])
        case .parser(let msg):
            self.display(title: "Parser", error: msg, actions: [okAction])
        }
        shouldLoadMoreObject = false
    }
    
    func displayArtists(viewModel: SearchArtist.ViewModel) {
        tableViewDataSource.artists = viewModel.artists
        tableView.reloadData()
        shouldLoadMoreObject = viewModel.shouldAllowLoadMore
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
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}

extension SearchArtistViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if distanceFromBottom < height, shouldLoadMoreObject == true {
            searchArtist(seed: searchBar.text, loadMore: true)
        }
    }
}
