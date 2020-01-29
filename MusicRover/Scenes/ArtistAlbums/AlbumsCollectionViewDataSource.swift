//
//  AlbumsCollectionViewDataSource.swift
//  MusicRover
//
//  Created by Dipak V. Vyawahare on 28/01/20.
//  Copyright © 2020 MyOrganization. All rights reserved.
//

import UIKit

class AlbumsCollectionCell: UICollectionViewCell {
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    private var imageLoadTask: URLSessionDataTask?
    var imageUrl: String = "" {
        didSet {
            albumImageView.image = UIImage(named: "Loading")
            imageLoadTask?.cancel() // Cancel older load request
            imageLoadTask = ImageLoader.shared.loadImage(urlString: imageUrl) { [weak self] (image, url) in
                if self?.imageUrl == url {
                    if let image = image {
                        self?.albumImageView.image = image
                    }
                }
            }
        }
    }
}

class AlbumsCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    var albums: [ArtistAlbums.ViewModel.RowDataSource] = []
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return albums.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlbumsCollectionCellId", for: indexPath)
        if let cell = cell as? AlbumsCollectionCell {
            let obj = albums[indexPath.row]
            cell.imageUrl = obj.image
            cell.nameLabel.text = obj.album
        }
        return cell
    }
}
