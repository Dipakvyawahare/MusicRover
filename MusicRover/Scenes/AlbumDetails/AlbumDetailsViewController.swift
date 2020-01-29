//
//  AlbumDetailsViewController.swift
//  MusicRover
//
//  Created by Dipak V. Vyawahare on 29/01/20.
//  Copyright (c) 2020 Globant Inc. All rights reserved.
//

import UIKit
import AVFoundation

class AlbumDetailsViewController: UIViewController {
    var output: AlbumDetailsViewControllerInteractorInterface?
    var router: AlbumDetailsRouter = AlbumDetailsRouter()
    lazy var tableViewDataSource = AlbumDetailsTableViewDataSource()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var playerButton: UIButton!
    var player: AVPlayer?
    
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
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.dataSource = tableViewDataSource
        tableView.delegate = self
        displayProgressHud(show: true)
    }
    
    func reload() {
        output?.reload()
        displayProgressHud(show: true)
    }
    
    func loadAlbumImage(imageUrl: String) {
        albumImageView.image = UIImage(systemName: "folder")
        _ = ImageLoader.shared.loadImage(urlString: imageUrl) { [weak self] (image, _) in
            if let image = image {
                self?.albumImageView.image = image
            }
        }
    }
    
    func play(url: String) throws {
        if let url = URL.init(string: url) {
            let playerItem: AVPlayerItem = AVPlayerItem(url: url)
            player?.pause()
            player = AVPlayer(playerItem: playerItem)
            let playerLayer = AVPlayerLayer(player: player!)
            playerLayer.frame = CGRect(x: 0, y: 0, width: 10, height: 50)
            albumImageView.layer.addSublayer(playerLayer)
            player?.play()
        }
    }
    
    @IBAction func pauseAudio() {
        player?.pause()
        playerButton.isHidden = true
    }
}

extension AlbumDetailsViewController: AlbumDetailsPresenterViewControllerInterface, AppDisplayable {
    func displayTracks(viewModel: AlbumDetails.ViewModel) {
        displayProgressHud(show: false)
        tableViewDataSource.tracks = viewModel.tracks
        tableView.reloadData()
        loadAlbumImage(imageUrl: viewModel.album.image)
        self.title = viewModel.title
    }
    
    func displayError(error: ErrorResult) {
        displayProgressHud(show: false)
        let retryAction = UIAlertAction(title: "Retry",
                                        style: .default) { [weak self] _ in
                                            self?.reload()
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
    }
}

extension AlbumDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        let link = tableViewDataSource.tracks[indexPath.row].preview
        do {
            try play(url: link)
            playerButton.isHidden = false
        } catch {
            print(error)
        }
    }
}
