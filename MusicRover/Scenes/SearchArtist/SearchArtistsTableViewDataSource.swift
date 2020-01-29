//
//  SearchArtistsTableViewDataSource.swift
//  MusicRover
//
//  Created by Dipak V. Vyawahare on 26/01/20.
//  Copyright © 2020 MyOrganization. All rights reserved.
//

import UIKit

class ArtistTableViewCell: UITableViewCell {
    @IBOutlet weak var artistImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    private var imageLoadTask: URLSessionDataTask?
    var imageUrl: String = "" {
        didSet {
            artistImageView.image = UIImage.init(systemName: "person")
            imageLoadTask?.cancel() // Cancel older load request
            imageLoadTask = ImageLoader.shared.loadImage(urlString: imageUrl) { [weak self] (image, url) in
                if self?.imageUrl == url {
                    self?.artistImageView.image = image
                }
            }
        }
    }
}

class SearchArtistsTableViewDataSource: NSObject, UITableViewDataSource {
    var artists: [SearchArtist.ViewModel.RowDataSource] = []
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return artists.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArtistTableViewCellId",
                                                 for: indexPath)
        if let cell = cell as? ArtistTableViewCell {
            let art = artists[indexPath.row]
            cell.imageUrl = art.image
            cell.descriptionLabel.text = art.description
            cell.nameLabel.text = art.name
        }
        return cell
    }
    
}
