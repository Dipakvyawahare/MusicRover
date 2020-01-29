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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
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
        searchBar.becomeFirstResponder()
    }
    
    @objc private func loadMoreArtist() {
        if let seed = searchBar.text, seed.count > 0 {
            let request = SearchArtist.Request(inputString: seed)
            output?.loadMoreArtist(request: request)
            displayProgressHud(show: true)
        }
    }
    
    @objc private func searchArtist() {
        if let seed = searchBar.text, seed.count > 0 {
            let request = SearchArtist.Request(inputString: seed)
            output?.searchArtist(request: request)
            displayProgressHud(show: true)
        }
    }
}

extension SearchArtistViewController: SearchArtistPresenterViewControllerInterface, AppDisplayable {
    
    func displayError(error: ErrorResult) {
        displayProgressHud(show: false)
        let retryAction = UIAlertAction(title: "Retry",
                                        style: .default) { [weak self] _ in
                                            self?.searchArtist()
        }
        let okAction = UIAlertAction(title: "Ok",
                                     style: .default,
                                     handler: nil)
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
        displayProgressHud(show: false)
        tableViewDataSource.artists = viewModel.artists
        tableView.reloadData()
        shouldLoadMoreObject = viewModel.shouldAllowLoadMore
    }
}

extension SearchArtistViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar,
                   textDidChange searchText: String) {
        let performAfterDelay = 0.5
        let selector = #selector(searchArtist)
        NSObject.cancelPreviousPerformRequests(withTarget: self,
                                               selector: selector,
                                               object: nil)
        perform(selector,
                with: nil,
                afterDelay: performAfterDelay)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}

extension SearchArtistViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router.navigateToArtistAlbums(row: tableViewDataSource.artists[indexPath.row])
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if distanceFromBottom < height, shouldLoadMoreObject == true {
            let performAfterDelay = 0.2
            let selector = #selector(loadMoreArtist)
            NSObject.cancelPreviousPerformRequests(withTarget: self,
                                                   selector: selector,
                                                   object: nil)
            perform(selector,
                    with: nil,
                    afterDelay: performAfterDelay)
        }
    }
}
