//
//  ArtistAlbumsViewController.swift
//  MusicRover
//
//  Created by Dipak V. Vyawahare on 27/01/20.
//  Copyright (c) 2020 MyOrganization Inc. All rights reserved.
//

import UIKit

class ArtistAlbumsViewController: UIViewController {
    var output: ArtistAlbumsViewControllerInteractorInterface?
    var router: ArtistAlbumsRouter = ArtistAlbumsRouter()
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
    var shouldLoadMoreObject = false
    lazy var collectionViewDataSource = AlbumsCollectionViewDataSource()
    private let spacing: CGFloat = 10.0
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupVIPCycle()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupVIPCycle()
    }
    
    private func setupVIPCycle() {
        let presenter = ArtistAlbumsPresenter()
        presenter.output = self
        let interactor = ArtistAlbumsInteractor()
        interactor.output = presenter
        self.output = interactor
        router.viewController = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = collectionViewDataSource
        collectionView.delegate = self
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: spacing,
                                           left: spacing,
                                           bottom: spacing,
                                           right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        collectionView.collectionViewLayout = layout
        displayProgressHud(show: true)
    }
    
    @objc func reload() {
        displayProgressHud(show: true)
        output?.loadMoreAlbums()
    }
}

extension ArtistAlbumsViewController: ArtistAlbumsPresenterViewControllerInterface, AppDisplayable {
    func displayAlbums(viewModel: ArtistAlbums.ViewModel) {
        displayProgressHud(show: false)
        collectionViewDataSource.albums = viewModel.albums
        collectionView.reloadData()
        shouldLoadMoreObject = viewModel.shouldAllowLoadMore
        self.title = viewModel.artistName
    }
    
    func displayError(error: ErrorResult) {
        displayProgressHud(show: false)
        let retryAction = UIAlertAction(title: "Retry",
                                        style: .default) { [weak self] _ in
                                            self?.reload()
        }
        let cancelAction = UIAlertAction(title: "Cancel",
                                        style: .default) { [weak self] _ in
                                            self?.navigationController?.popViewController(animated: true)
        }
        let okAction = UIAlertAction(title: "Ok",
                                     style: .default,
                                     handler: nil)
        switch error {
        case .custom(let msg):
            self.display(title: "Alert", error: msg, actions: [retryAction, cancelAction])
        case .network(let msg):
            self.display(title: "Network", error: msg, actions: [retryAction, cancelAction])
        case .parser(let msg):
            self.display(title: "Parser", error: msg, actions: [okAction])
        }
        shouldLoadMoreObject = false
    }
}

extension ArtistAlbumsViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfItemsPerRow: CGFloat = 2
        let spacingBetweenCells: CGFloat = 10
        //Amount of total spacing in a row
        let totalSpacing = (2 * spacing) + ((numberOfItemsPerRow - 1) * spacingBetweenCells)
        let width = (collectionView.bounds.width - totalSpacing)/numberOfItemsPerRow
        return CGSize(width: width, height: width * 1.3)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        router.navigateToDetails(row: collectionViewDataSource.albums[indexPath.item])
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if distanceFromBottom < height, shouldLoadMoreObject == true {
            let performAfterDelay = 0.2
            let selector = #selector(reload)
            NSObject.cancelPreviousPerformRequests(withTarget: self,
                                                   selector: selector,
                                                   object: nil)
            perform(selector,
                    with: nil,
                    afterDelay: performAfterDelay)
        }
    }
}
